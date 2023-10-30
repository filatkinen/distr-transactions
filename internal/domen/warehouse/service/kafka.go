package service

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/IBM/sarama"
	"github.com/filatkinen/distr-transactions/internal/model"
)

func (s *Service) KafkaGetMessage(message *sarama.ConsumerMessage) {
	ctx := context.Background()
	switch message.Topic {
	case model.TopicOrderWareHouse:
		var whMessage model.WarehouseMessage
		err := json.Unmarshal(message.Value, &whMessage)
		if err != nil {
			s.logger.Error("Step 1- Error unmarshalling message from OrderService", "err", err)
			return
		}
		err = s.domenWareHouseReserv(ctx, whMessage)
		if err != nil {
			s.logger.Error("Step 2- Error lunching worker task to reserv", "err", err)
			return
		}
		s.logger.Info("Adding worker to reserv items", "Order ID", whMessage.OrderID)
	case model.TopicOrderWareHouseCancel:
		var whMessage model.WarehouseMessageCancel
		err := json.Unmarshal(message.Value, &whMessage)
		if err != nil {
			s.logger.Error("Step 1- Error unmarshalling message from OrderService to cancel reserv", "err", err)
			return
		}
		err = s.domenWareHouseReservCancel(ctx, whMessage)
		if err != nil {
			s.logger.Error("Step 2- Error lunching worker task to cancel reserv", "err", err)
			return
		}
		s.logger.Info("Adding worker to cancel reserv items", "Order ID", whMessage.OrderID)
	default:
		fmt.Printf("Message claimed: value = %s, topic = %s, partition%d, offset:%d\n",
			string(message.Value), message.Topic, message.Partition, message.Offset)
	}
}

func (s *Service) KafkaGetError(err error) {
	fmt.Printf("got error:%v\n", err)
}
