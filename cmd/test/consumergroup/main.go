package main

import (
	"flag"
	"fmt"
	"github.com/IBM/sarama"
	"github.com/filatkinen/distr-transactions/internal/kafka"
	"log/slog"
	"os"
	"os/signal"
	"sync"
	"syscall"
)

func main() {
	topics := flag.String("topics", "two.topic", "topic to connect")
	connstring := flag.String("connstring", "localhost:9092", "kafka conn string")
	group := flag.String("group", "test2", "Kafka consumer group definition")
	clientID := flag.String("clientID", "client01", "Kafka clientID")

	fMessage := func(message *sarama.ConsumerMessage) {
		fmt.Printf("Message claimed: value = %s, topic = %s, partition%d, offset:%d\n",
			string(message.Value), message.Topic, message.Partition, message.Offset)
	}

	fError := func(err error) {
		fmt.Printf("got error:%v\n", err)
	}

	logHandler := slog.NewTextHandler(os.Stdout, nil)
	logger := slog.New(logHandler)

	consumerGroup, err := kafka.NewConsumerGroup(func() *sarama.Config {
		config := sarama.NewConfig()
		return config
	}, logHandler,
		true,
		*connstring,
		*group,
		*topics,
		kafka.RebalanceGroupRange,
		sarama.OffsetOldest,
		*clientID,
		fMessage,
		fError,
	)

	if err != nil {
		logger.Error("error creating clientGroup", err)
		return
	}
	defer func() {
		if err := consumerGroup.Close(); err != nil {
			logger.Error("error closing Consumer Group", err)
		}
	}()

	sigusr1 := make(chan os.Signal, 1)
	signal.Notify(sigusr1, syscall.SIGUSR1)

	sigterm := make(chan os.Signal, 1)
	signal.Notify(sigterm, syscall.SIGINT, syscall.SIGTERM)

	sigStopConsuming := make(chan bool)

	wg := sync.WaitGroup{}
	wg.Add(1)
	go func() {
		defer wg.Done()
		err := consumerGroup.MessageConsumeStart()
		if err != nil {
			logger.Error("error starting consumer group", err)

		}
		logger.Info("exiting consuming")
		close(sigStopConsuming)
	}()

	isPaused := false

	keepRunning := true
	for keepRunning {
		select {
		case <-sigStopConsuming:
			keepRunning = false
		case <-sigterm:
			logger.Info("terminating: via signal")
			consumerGroup.MessageConsumeStop()
			keepRunning = false
		case <-sigusr1:
			logger.Info("switching: via signal")
			if isPaused {
				consumerGroup.MessageConsumeResume()
			} else {
				consumerGroup.MessageConsumePause()
			}
			isPaused = !isPaused
		}
	}

	wg.Wait()
}
