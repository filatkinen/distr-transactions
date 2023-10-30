package service

import (
	"context"
	"encoding/json"
	"github.com/filatkinen/distr-transactions/internal/model"
	"log/slog"
)

func (s *Service) NewOrder(ctx context.Context, order model.Order) (orderInfo model.OrderNotification, err error) {
	orderID, err := s.orderDBNew(ctx, order)
	if err != nil {
		orderInfo.OrderID = 0
		orderInfo.Status = model.OrderStatusNotOk
		return orderInfo, err
	}
	orderInfo.OrderID = orderID
	orderInfo.Status = model.OrderStatusNew

	order.OrderID = orderID

	b, err := json.Marshal(&order)
	_, _, err = s.Producer.SendBytes(model.TopicOrder, b)
	if err != nil {
		s.logger.Error("Sending new order to kafka:", "err", err, slog.Int("OrderID", int(orderID)))
		return orderInfo, err
	}

	orderInfo.Status = model.OrderStatusProcess
	err = s.orderDBSetStatus(ctx, orderInfo)
	if err != nil {
		s.logger.Error("Setting changing status Order to process:", "err", err,
			slog.Int("OrderID", int(orderID)),
			slog.Int("Status", int(model.OrderStatusNew)))
		return orderInfo, err
	}

	orderInfo.Status = model.OrderStatusProcess
	return orderInfo, nil
}
