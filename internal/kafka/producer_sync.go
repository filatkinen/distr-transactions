package kafka

import (
	"errors"
	"github.com/IBM/sarama"
	"log"
	"log/slog"
	"strings"
)

type ProducerSync struct {
	producer sarama.SyncProducer
	log      *log.Logger
}

func NewSyncProducer(config func() *sarama.Config, connString string, logHandler slog.Handler, logVerbose bool,
	clientID string) (*ProducerSync, error) {

	if logHandler == nil {
		return nil, errors.New("empty slog.handler")
	}
	logger := slog.NewLogLogger(logHandler, slog.LevelInfo)
	if logVerbose {
		sarama.Logger = logger
	}

	conf := config()
	conf.ClientID = clientID
	producer, err := sarama.NewSyncProducer(strings.Split(connString, ","), conf)
	if err != nil {
		return nil, err
	}
	return &ProducerSync{producer: producer, log: logger}, nil
}

func (c *ProducerSync) SendBytes(topic string, message []byte) (int32, int64, error) {
	msg := &sarama.ProducerMessage{
		Topic: topic,
		Value: sarama.ByteEncoder(message),
	}
	return c.producer.SendMessage(msg)
}

func (c *ProducerSync) SendString(topic string, message string) (int32, int64, error) {
	msg := &sarama.ProducerMessage{
		Topic: topic,
		Value: sarama.StringEncoder(message),
	}
	return c.producer.SendMessage(msg)
}

func (c *ProducerSync) Close() error {
	return c.producer.Close()
}
