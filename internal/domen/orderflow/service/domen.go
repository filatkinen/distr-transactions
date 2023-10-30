package service

import (
	"context"
	"encoding/json"
	"github.com/filatkinen/distr-transactions/internal/model"
)

func (s *Service) domenOrderStartFlow(ctx context.Context, order model.Order) (err error) {
	orderID, err := s.dbOrderAdd(ctx, order)
	if err != nil {
		s.logger.Error("Error creating new flow", "err", err, "step adding", 1)
		return err
	}
	err = s.domenOrderStepWareHouse(ctx, orderID)
	if err != nil {
		s.logger.Error("Error creating new flow", "err", err, "step sending warehouse", 2)
		return err
	}
	return err
}

func (s *Service) domenOrderStepWareHouse(ctx context.Context, orderID uint32) (err error) {
	order, err := s.dbOrderGet(ctx, orderID)
	if err != nil {
		s.logger.Error("Error sending message to Warehouse", "err", err, "step sending new", 1)
		return err
	}
	var whMessage model.WarehouseMessage
	whMessage.OrderID = orderID
	whMessage.Items = append(whMessage.Items, order.Items...)

	b, err := json.Marshal(whMessage)
	if err != nil {
		s.logger.Error("Error sending message to Warehouse", "err", err, "step marshaling", 2)
		return err
	}
	_, _, err = s.Producer.SendBytes(model.TopicOrderWareHouse, b)
	if err != nil {
		s.logger.Error("Error sending message to Warehouse", "err", err, "step sending Kafka", 3)
		return err
	}
	return err
}

func (s *Service) domenOrderStepWareHouseCancel(ctx context.Context, orderID uint32) (err error) {
	var whMessage model.WarehouseMessageCancel
	whMessage.OrderID = orderID

	b, err := json.Marshal(whMessage)
	if err != nil {
		s.logger.Error("Error sending cancel message to Warehouse", "err", err, "step marshaling", 1)
		return err
	}
	_, _, err = s.Producer.SendBytes(model.TopicOrderWareHouseCancel, b)
	if err != nil {
		s.logger.Error("Error sending message to Warehouse", "err", err, "step sending Kafka", 2)
		return err
	}
	return err
}

func (s *Service) domenOrderStepPayment(ctx context.Context, orderID uint32) (err error) {
	order, err := s.dbOrderGet(ctx, orderID)
	if err != nil {
		s.logger.Error("Error sending message to Payment", "err", err, "step db query", 1)
		return err
	}
	var pMessage model.PaymentMessage
	pMessage.OrderID = orderID
	pMessage.Payment = order.Payment
	pMessage.Sum = order.Sum
	pMessage.UserID = order.UserID

	b, err := json.Marshal(pMessage)
	if err != nil {
		s.logger.Error("Error sending message to Payment", "err", err, "step marshaling", 2)
		return err
	}
	_, _, err = s.Producer.SendBytes(model.TopicOrderPayment, b)
	if err != nil {
		s.logger.Error("Error sending message to Payment", "err", err, "step sending Kafka", 3)
		return err
	}
	return err
}

func (s *Service) domenOrderStepNotification(ctx context.Context, orderID uint32) (err error) {
	order, err := s.dbOrderGet(ctx, orderID)
	if err != nil {
		s.logger.Error("Error sending message to Notification", "err", err, "step db query", 1)
		return err
	}
	var pMessage model.NotificationMessage
	pMessage.OrderID = orderID
	pMessage.UserID = order.UserID
	pMessage.Notification = order.Notification

	b, err := json.Marshal(pMessage)
	if err != nil {
		s.logger.Error("Error sending message to Notification", "err", err, "step marshaling", 2)
		return err
	}
	_, _, err = s.Producer.SendBytes(model.TopicOrderNotification, b)
	if err != nil {
		s.logger.Error("Error sending message to Notification", "err", err, "step sending Kafka", 3)
		return err
	}
	return err
}

func (s *Service) domenOrderFinishFlow(ctx context.Context, orderID uint32, resultStatus model.OrderStatus) (err error) {
	var msg model.OrderNotification

	details, err := s.dbOrderGetStatusesAsString(ctx, orderID)
	if err != nil {
		s.logger.Error("Error sending final message to order service", "err", err, "step querying details ", 1)
	}

	msg.OrderID = orderID
	msg.Status = resultStatus
	msg.Detail = details

	b, err := json.Marshal(msg)
	if err != nil {
		s.logger.Error("Error sending final message to order service", "err", err, "step marshaling", 2)
		return err
	}
	_, _, err = s.Producer.SendBytes(model.TopicOrderStatus, b)
	if err != nil {
		s.logger.Error("Error sending final message to order service", "err", err, "step sending Kafka", 3)
		return err
	}
	return err

}
