package service

import (
	"context"
	"encoding/json"
	"github.com/filatkinen/distr-transactions/internal/model"
	"log/slog"
	"math/rand"
	"time"
)

func (s *Service) workerStartJobSend(ctx context.Context, whMessage model.NotificationMessage) {
	src := rand.NewSource(time.Now().UnixNano())
	rnd := rand.New(src) //nolint:gosec

	var result model.ServiceNotification
	result.OrderID = whMessage.OrderID
	result.ServiceID = model.ServiceIDNotification
	if s.Mistakes == 0 {
		result.Status = model.ServiceStatusOK
	} else if s.Mistakes >= (rnd.Intn(100) + 1) {
		result.Status = model.ServiceStatusNotOK
		result.Detail = "Error notification"
	}

	// simulating service dalay from 200 mc to 500
	time.Sleep(time.Millisecond*time.Duration(rnd.Intn(400)) + time.Millisecond*100)
	result.StatusAt = time.Now().UTC().Truncate(time.Millisecond)

	b, err := json.Marshal(result)
	if err != nil {
		s.logger.Error("Error marshaling message after notification to send to orderflow ", "err", err)
		return
	}
	_, _, err = s.Producer.SendBytes(model.TopicOrderNotificationStatus, b)
	if err != nil {
		s.logger.Error("Error sending  message after notification to send to orderflow ", "err", err)
		return
	}
	s.logger.Info("Finish worker to notification", "Order ID", whMessage.OrderID,
		slog.String("result", result.Status.String()))
}
