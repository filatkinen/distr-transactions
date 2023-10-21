package main

import (
	"flag"
	"fmt"
	"github.com/IBM/sarama"
	"github.com/filatkinen/distr-transactions/internal/kafka"
	"log/slog"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	topic := flag.String("topic", "two.topic", "topic to connect")
	connstring := flag.String("connstring", "localhost:9092", "kafka conn string")

	logHandler := slog.NewJSONHandler(os.Stdout, nil)
	logger := slog.New(logHandler)

	consumer, err := kafka.NewConsumer(func() *sarama.Config {
		config := sarama.NewConfig()
		config.Consumer.Return.Errors = true
		return config
	}, logHandler, true, *connstring, *topic, "kafka-client",
		func(message *sarama.ConsumerMessage) {
			fmt.Println(
				slog.Int64("Offset", message.Offset),
				slog.Int("Patrition", int(message.Partition)),
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
