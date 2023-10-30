package service

import (
	"context"
	"github.com/filatkinen/distr-transactions/internal/model"
)

func (s *Service) domenPaymentPay(ctx context.Context, whMessage model.PaymentMessage) (err error) {
	s.wg.Add(1)
	go func() {
		defer s.wg.Done()
		s.workerStartJobPay(ctx, whMessage)
	}()
	return err
}
