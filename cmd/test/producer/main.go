package main

import (
	"flag"
	"fmt"
	"github.com/IBM/sarama"
	"github.com/filatkinen/distr-transactions/internal/kafka"
	"log"
	"log/slog"
	"os"
	"time"
)

func main() {
	topic := flag.String("topic", "two.topic", "topic to connect")
	connstring := flag.String("connstring", "localhost:9092", "kafka conn string")
	clientID := flag.String("clientID", "kakka-Client", "kafka clientID")
	//func NewSyncProducer(config func() *sarama.Config, connString string, logHandler slog.Handler, logVerbose bool) (*ProducerSync, error) {

	logHandler := slog.NewJSONHandler(os.Stdout, nil)
	//logger := slog.New(logHandler)

	producer, err := kafka.NewSyncProducer(func() *sarama.Config {
		config := sarama.NewConfig()
		config.Producer.Return.Successes = true
		config.Producer.RequiredAcks = sarama.WaitForAll
		config.Producer.Retry.Max = 5
		return config
	},
		*connstring, logHandler, false, *clientID)

	if err != nil {
		log.Fatal(err)
	}
	defer func() {
		if err := producer.Close(); err != nil {
			log.Println(err)
		}

	}()

	for i := 1; i < 24; i++ {
		message := time.Now().String()
		partition, offset, err := producer.SendString(*topic, message)
		if err != nil {
			log.Println(err)
			break
		}
		fmt.Printf("partition=%d, offset=%d, topic=%s, message=%s\n", partition, offset, *topic, message)
	}
}
