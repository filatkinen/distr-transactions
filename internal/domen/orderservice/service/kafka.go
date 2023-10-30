package service

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/IBM/sarama"
	"github.com/filatkinen/distr-transactions/internal/model"
	"log/slog"
)

func (s *Service) KafkaGetMessage(message *sarama.ConsumerMessage) {
	switch message.Topic {
	case model.TopicOrderStatus:
		var status model.OrderNotification
		err := json.Unmarshal(message.Value, &status)
		if err != nil {
			s.logger.Error("Unmarshalling status", "err", err)
			return
		}
		err = s.orderDBSetStatus(context.Background(), status)
		if err != nil {
			s.logger.Error("Updating  status", "err", err)
			return
		}
		s.logger.Info("Getting result of processing", "Order ID", status.OrderID,
			slog.String("result", status.Status.String()))
	default:
		fmt.Printf("Message claimed: value = %s, topic = %s, partition%d, offset:%d\n",
			string(message.Value), message.Topic, message.Partition, message.Offset)
	}
}

func (s *Service) KafkaGetError(err error) {
	fmt.Printf("got error:%v\n", err)
}
