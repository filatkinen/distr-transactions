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
	ctx := context.Background()
	switch message.Topic {
	case model.TopicOrder:
		var order model.Order
		err := json.Unmarshal(message.Value, &order)
		if err != nil {
			s.logger.Error("Step 1- Error unmarshalling message", "err", err)
			return
		}
		err = s.domenOrderStartFlow(ctx, order)
		if err != nil {
			s.logger.Error("Step 1- Error Fixing new order", "err", err)
			return
		}
		s.logger.Info("Received message from order service, sending to Warehouse", "Order ID", order.OrderID)
	case model.TopicOrderWareHouseStatus:
		var status model.ServiceNotification
		err := json.Unmarshal(message.Value, &status)
		if err != nil {
			s.logger.Error("Step 2- Error unmarshalling message from Warehouse", "err", err)
			return
		}
		err = s.dbOrderAddStatusService(ctx, status)
		if err != nil {
			s.logger.Error("Step 2- Error adding status to service_status from Warehouse", "err", err)
			return
		}
		switch status.Status {
		case model.ServiceStatusOK:
			err = s.domenOrderStepPayment(ctx, status.OrderID)
			if err != nil {
				s.logger.Error("Step 2- Error sending message to  Payment", "err", err)
				return
			}
			s.logger.Info("Received OK message Warehouse, sending to Payment", "Order ID", status.OrderID,
				slog.String("result", status.Status.String()))
		case model.ServiceStatusNotOK:
			err = s.domenOrderFinishFlow(ctx, status.OrderID, model.OrderStatusNotOk)
			if err != nil {
				s.logger.Error("Step 2- Error sending final cancel message to  Order", "err", err)
				return
			}
			s.logger.Info("Received NOT_OK message Warehouse, Finishing order, informing Order Service", "Order ID", status.OrderID,
				slog.String("result", status.Status.String()))
		}
	case model.TopicOrderPaymentStatus:
		var status model.ServiceNotification
		err := json.Unmarshal(message.Value, &status)
		if err != nil {
			s.logger.Error("Step 3- Error unmarshalling message from Payment", "err", err)
			return
		}
		err = s.dbOrderAddStatusService(ctx, status)
		if err != nil {
			s.logger.Error("Step 3- Error adding status to service_status from Payment", "err", err)
			return
		}
		switch status.Status {
		case model.ServiceStatusOK:
			err = s.domenOrderStepNotification(ctx, status.OrderID)
			if err != nil {
				s.logger.Error("Step 3- Error sending message to  Notification", "err", err)
				return
			}
			s.logger.Info("Received OK message Payment, sending to Notification", "Order ID", status.OrderID,
				slog.String("result", status.Status.String()))
		case model.ServiceStatusNotOK:
			err = s.domenOrderStepWareHouseCancel(ctx, status.OrderID)
			if err != nil {
				s.logger.Error("Step 3- Error cancel Warehouse", "err", err)
				return
			}
			err = s.domenOrderFinishFlow(ctx, status.OrderID, model.OrderStatusNotOk)
			if err != nil {
				s.logger.Error("Step 3- Error sending final cancel message to Order", "err", err)
				return
			}
			s.logger.Info("Received NOT_OK message Payment, Finishing order, informing Order Service", "Order ID", status.OrderID,
				slog.String("result", status.Status.String()))
		}
	case model.TopicOrderNotificationStatus:
		var status model.ServiceNotification
		err := json.Unmarshal(message.Value, &status)
		if err != nil {
			s.logger.Error("Step 4- Error unmarshalling message from Notification", "err", err)
			return
		}
		err = s.dbOrderAddStatusService(ctx, status)
		if err != nil {
			s.logger.Error("Step 4- Error adding status to service_status from Notification", "err", err)
			return
		}
		err = s.domenOrderFinishFlow(ctx, status.OrderID, model.OrderStatusOk)
		if err != nil {
			s.logger.Error("Step 4- Error sending final OK message to Order", "err", err)
			return
		}
		s.logger.Info("Received OK message Notification, Finishing order, informing Order Service", "Order ID", status.OrderID,
			slog.String("result", status.Status.String()))
	default:
		fmt.Printf("Message claimed: value = %s, topic = %s, partition%d, offset:%d\n",
			string(message.Value), message.Topic, message.Partition, message.Offset)
	}
}

func (s *Service) KafkaGetError(err error) {
	fmt.Printf("got error:%v\n", err)
}
