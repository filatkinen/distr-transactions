package service

import (
	"context"
	"errors"
	"github.com/IBM/sarama"
	"github.com/filatkinen/distr-transactions/internal/domen"
	"github.com/filatkinen/distr-transactions/internal/kafka"
	"github.com/filatkinen/distr-transactions/internal/storage"
	"log/slog"
	"net"
	"net/http"
	"sync"
	"time"
)

type SetService struct {
	Mistakes int `json:"mistakes"` // mistakes percent
}

type Service struct {
	storage        *storage.Database
	srv            *http.Server
	Consumer       *kafka.ConsumerGroup
	Producer       *kafka.ProducerSync
	logger         *slog.Logger
	ProducerTopics string
	ConsumerTopics string
	Mistakes       int
	lock           sync.Mutex
}

func New(port string,
	configDB storage.DBConfig,
	configP domen.ProducerConfig,
	configC domen.ConsumerConfig,
	log *slog.Logger) (*Service, error) {

	service := Service{
		srv: &http.Server{
			Addr:              net.JoinHostPort("0.0.0.0", port),
			ReadHeaderTimeout: time.Second * 5,
		},
	}
	service.srv.Handler = service.getroute()
	service.logger = log

	db, err := storage.New(configDB)
	if err != nil {
		return nil, err
	}
	service.storage = db
	service.logger.Info("Successfully connecting to the database")

	service.ProducerTopics = configP.Topics
	producer, err := kafka.NewSyncProducer(func() *sarama.Config {
		config := sarama.NewConfig()
		config.Producer.Return.Successes = true
		config.Producer.RequiredAcks = sarama.WaitForAll
		config.Producer.Retry.Max = 5
		return config
	},
		configP.ConnString, service.logger.Handler(), configP.LogVerbose, configP.ClientID)
	if err != nil {
		return nil, errors.Join(err, service.closeDB())
	}
	service.Producer = producer

	service.ConsumerTopics = configC.Topics
	consumer, err := kafka.NewConsumerGroup(func() *sarama.Config {
		config := sarama.NewConfig()
		return config
	}, service.logger.Handler(),
		configC.LogVerbose,
		configC.ConnString,
		configC.Group,
		configC.Topics,
		kafka.RebalanceGroupRange,
		sarama.OffsetOldest,
		configC.ClientID,
		service.KafkaGetMessage,
		service.KafkaGetError,
	)
	if err != nil {
		return nil, errors.Join(err, service.closeDB(), service.Producer.Close())
	}
	service.Consumer = consumer

	return &service, nil
}

func (s *Service) Start() error {
	sigStopHTTP := make(chan bool)
	sigStopConsuming := make(chan bool)

	var errorHTTP, errorConsumer error

	wg := sync.WaitGroup{}
	wg.Add(1)
	go func() {
		defer wg.Done()
		s.logger.Info("Starting Consumer")
		errorConsumer = s.Consumer.MessageConsumeStart()
		if errorConsumer != nil {
			s.logger.Error("error starting consumer group", "err", errorConsumer)
		}
		s.logger.Info("Exiting consuming worker")
		close(sigStopConsuming)
	}()

	wg.Add(1)
	go func() {
		defer wg.Done()
		s.logger.Info("Starting HTTP Server")
		errorHTTP = s.srv.ListenAndServe()
		if !errors.Is(errorHTTP, http.ErrServerClosed) {
			s.logger.Error("Error starting HTTP Server", "err", errorHTTP)
		} else {
			errorHTTP = nil
		}
		s.logger.Info("Exiting HTTP Server worker")
		close(sigStopHTTP)
	}()

	select {
	case <-sigStopHTTP:
		if errorHTTP != nil {
			if e := s.Stop(); e != nil {
				s.logger.Error("Error closing service", "err", e)
			}
		}
	case <-sigStopConsuming:
		if errorConsumer != nil {
			if e := s.Stop(); e != nil {
				s.logger.Error("Error closing service", "err", e)
			}
		}
	}
	wg.Wait()

	return errors.Join(errorConsumer, errorHTTP)
}

func (s *Service) Stop() error {

	ctx, cancel := context.WithTimeout(context.Background(), time.Second*3)
	defer cancel()
	err := s.srv.Shutdown(ctx)
	if err != nil {
		s.logger.Error("HTTP shutdown error:", "err", err)
		return err
	}
	s.logger.Info("HTTP graceful shutdown complete.")

	s.Consumer.MessageConsumeStop()
	s.logger.Info("Kafka Consumer shutdown complete.")

	return nil
}

func (s *Service) Close() error {
	return errors.Join(s.closeDB(), s.Producer.Close(), s.Consumer.Close())
}

func (s *Service) closeDB() error {
	s.logger.Info("Closing Database...")
	return s.storage.Close()
}
