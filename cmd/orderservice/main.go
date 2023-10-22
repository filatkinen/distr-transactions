package main

import (
	"github.com/filatkinen/distr-transactions/internal/domen"
	"github.com/filatkinen/distr-transactions/internal/domen/orderservice/service"
	"github.com/filatkinen/distr-transactions/internal/model"
	"github.com/filatkinen/distr-transactions/internal/storage"
	"github.com/joho/godotenv"
	"log"
	"log/slog"
	"os"
	"os/signal"
	"sync"
	"syscall"
)

func main() {

	err := godotenv.Load("orderservice.env")
	if err != nil {
		log.Fatal(err)
	}

	dbConnURL := os.Getenv("DBCONNURL")
	connstring := os.Getenv("KAFKABROKERS")
	group := os.Getenv("CONSUMERGROUPID")
	clientID := os.Getenv("CLIENTID")
	servicePort := os.Getenv("SERVICEPORT")

	logHandler := slog.NewJSONHandler(os.Stdout, nil)
	logger := slog.New(logHandler)

	serv, err := service.New(servicePort, storage.DBConfig{
		ConnString: dbConnURL,
		MaxConn:    10,
		MinConn:    5,
	}, domen.ProducerConfig{
		Topics:     model.TopicOrder,
		ConnString: connstring,
		ClientID:   clientID,
		LogVerbose: false,
	}, domen.ConsumerConfig{
		Topics:     model.TopicOrderStatus,
		ConnString: connstring,
		ClientID:   clientID,
		LogVerbose: false,
		Group:      group,
	}, logger)

	if err != nil {
		logger.Error("error creating Service", "err", err)
		os.Exit(1)
	}

	sigterm := make(chan os.Signal, 1)
	signal.Notify(sigterm, syscall.SIGINT, syscall.SIGTERM)

	sigStopService := make(chan bool)

	var errService error

	wg := sync.WaitGroup{}
	wg.Add(1)
	go func() {
		defer wg.Done()
		errService = serv.Start()
		if errService != nil {
			logger.Error("error starting serv", "err", errService)
		}
		logger.Info("exiting service")
		close(sigStopService)
	}()

	select {
	case <-sigStopService:
	case <-sigterm:
		logger.Info("terminating: via signal")
		if err := serv.Stop(); err != nil {
			logger.Error("error stopping serv", "err", err)
		}
	}
	wg.Wait()

	if err := serv.Close(); err != nil {
		logger.Error("error closing service", err)
	}

	if errService != nil {
		os.Exit(1)
	}
}
