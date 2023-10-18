package main

import (
	"flag"
	"github.com/IBM/sarama"
	"github.com/filatkinen/distr-transactions/internal/kafka"
	"log/slog"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	topic := flag.String("topic", "one.topic", "topic to connect")
	connstring := flag.String("connstring", "localhost:9092", "kafka conn string")

	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))

	config := sarama.NewConfig()
	config.Consumer.Return.Errors = true
	consumer, err := kafka.NewConsumer(config, logger, *connstring, *topic,
		func(message *sarama.ConsumerMessage) {
			logger.Info("got message",
				slog.Int64("Offset", message.Offset),
				slog.String("topic", message.Topic),
				slog.String("message", string(message.Value)))
		}, nil)
	if err != nil {
		logger.Error("error", "got error creating consumer", err)
		return
	}
	defer consumer.Close()

	err = consumer.ConsumeMessageStart(sarama.OffsetOldest)
	if err != nil {
		logger.Error("cannot start consume:", err)
		return
	}

	chanExit := make(chan os.Signal, 1)
	signal.Notify(chanExit, syscall.SIGINT, syscall.SIGTERM, syscall.SIGHUP)
	<-chanExit
}
