package service

import (
	"context"
	"github.com/filatkinen/distr-transactions/internal/model"
)

func (s *Service) domenNotificationSend(ctx context.Context, whMessage model.NotificationMessage) (err error) {
	s.wg.Add(1)
	go func() {
		defer s.wg.Done()
		s.workerStartJobSend(ctx, whMessage)
	}()
	return err
}
