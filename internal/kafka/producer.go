package kafka

import (
	"github.com/IBM/sarama"
	"log/slog"
)

type Producer struct {
	producer sarama.SyncProducer
	log      *slog.Logger
}

func NewSyncProducer(conf *sarama.Config, connString string, logger *slog.Logger) (*Producer, error) {
	producer, err := sarama.NewSyncProducer([]string{connString}, conf)
	if err != nil {
		return nil, err
	}
	return &Producer{producer: producer, log: logger}, nil
}

func (c *Producer) Close() error {
	return c.producer.Close()
}
