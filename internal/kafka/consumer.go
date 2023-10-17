package kafka

import (
	"github.com/IBM/sarama"
	"log"
	"log/slog"
)

type Consumer struct {
	consumer sarama.Consumer
	log      *slog.Logger
	topic    string
}

func NewConsumer(conf *sarama.Config, connString string, logger *slog.Logger, topic string, f func(*sarama.ConsumerMessage)) (*Consumer, error) {
	consumer, err := sarama.NewConsumer([]string{connString}, conf)
	if err != nil {
		return nil, err
	}
	return &Consumer{consumer: consumer, log: logger}, nil
}

func (c *Consumer) Start() error {

}

func (c *Consumer) Close() error {
	return c.consumer.Close()
}

func (c *Consumer) Getmessage() {
	consumer, _ := sarama.NewConsumer([]string{"localhost:9092"}, nil)
	partitionList, _ := consumer.Partitions("test")
	for _, partition := range partitionList {
		pc, _ := consumer.ConsumePartition("test", partition, sarama.OffsetOldest)
		go func(pc sarama.PartitionConsumer) {
			for message := range pc.Messages() {
				log.Printf("received message %v\n", string(message.Value))
			}
		}(pc)
	}
}
