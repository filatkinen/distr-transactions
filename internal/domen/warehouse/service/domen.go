package service

import (
	"context"
	"github.com/filatkinen/distr-transactions/internal/model"
)

func (s *Service) domenWareHouseReserv(ctx context.Context, whMessage model.WarehouseMessage) (err error) {
	s.wg.Add(1)
	go func() {
		defer s.wg.Done()
		s.workerStartJobReserv(ctx, whMessage)
	}()
	return err
}

func (s *Service) domenWareHouseReservCancel(ctx context.Context, whMessage model.WarehouseMessageCancel) (err error) {
	s.wg.Add(1)
	go func() {
		defer s.wg.Done()
		s.workerStartJobReservCancel(ctx, whMessage)
	}()
	return err
}
