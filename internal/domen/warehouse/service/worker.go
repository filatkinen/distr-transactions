package service

import (
	"context"
	"encoding/json"
	"github.com/filatkinen/distr-transactions/internal/model"
	"math/rand"
	"time"
)

func (s *Service) workerStartJobReserv(ctx context.Context, whMessage model.WarehouseMessage) {
	src := rand.NewSource(time.Now().UnixNano())
	rnd := rand.New(src) //nolint:gosec

	var result model.ServiceNotification
	result.OrderID = whMessage.OrderID
	result.ServiceID = model.ServiceIDWarehouse
	if s.Mistakes == 0 {
		result.Status = model.ServiceStatusOK
	} else if s.Mistakes >= (rnd.Intn(100) + 1) {
		result.Status = model.ServiceStatusNotOK
		result.Detail = "Error reserving items"
	}

	// simulating service dalay from 200 mc to 5000
	time.Sleep(time.Millisecond*time.Duration(rnd.Intn(400)) + time.Millisecond*100)
	result.StatusAt = time.Now().UTC().Truncate(time.Millisecond)

	b, err := json.Marshal(result)
	if err != nil {
		s.logger.Error("Error marshaling message after reserv to send to orderflow ", "err", err)
		return
	}
	_, _, err = s.Producer.SendBytes(model.TopicOrderWareHouseStatus, b)
	if err != nil {
		s.logger.Error("Error sending  message after reserv to send to orderflow ", "err", err)
		return
	}
	s.logger.Info("Finish worker to reserv items", "Order ID", whMessage.OrderID)

}

func (s *Service) workerStartJobReservCancel(ctx context.Context, whMessage model.WarehouseMessageCancel) {
	src := rand.NewSource(time.Now().UnixNano())
	rnd := rand.New(src) //nolint:gosec

	var result model.ServiceNotification
	result.OrderID = whMessage.OrderID
	result.ServiceID = model.ServiceIDWarehouse
	result.Status = model.ServiceStatusOK

	// simulating service dalay from 100 mc to 500
	time.Sleep(time.Millisecond*time.Duration(rnd.Intn(400)) + time.Millisecond*100)
	result.StatusAt = time.Now().UTC().Truncate(time.Millisecond)
	result.Detail = "Reserv canceled"

	b, err := json.Marshal(result)
	if err != nil {
		s.logger.Error("Error marshaling message after reserv cancel to send to orderflow ", "err", err)
		return
	}
	_, _, err = s.Producer.SendBytes(model.TopicOrderWareHouseStatus, b)
	if err != nil {
		s.logger.Error("Error sending  message after reserv cancel to send to orderflow ", "err", err)
		return
	}
	s.logger.Info("Finish worker to cancel reserv items", "Order ID", whMessage.OrderID)

}
