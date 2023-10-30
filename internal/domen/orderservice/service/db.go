package service

import (
	"context"
	"github.com/filatkinen/distr-transactions/internal/model"
)

func (s *Service) orderDBNew(ctx context.Context, order model.Order) (orderID uint32, err error) {
	tx, err := s.storage.DB.Begin(ctx)
	if err != nil {
		return 0, err
	}
	defer func() {
		tx.Rollback(ctx)
	}()

	query := `INSERT INTO orders (user_id, notification_type, created_at, approved_at, sum, status)
				VALUES ($1,$2,NOW(),NOW(),$3,$4) 
				RETURNING order_id`
	err = tx.QueryRow(ctx, query, order.UserID, order.Notification, order.Sum, model.OrderStatusNew).
		Scan(&orderID)
	if err != nil {
		return 0, err
	}

	query = `INSERT INTO order_items(order_id, item_id, quantity, price) VALUES ($1,$2,$3,$4)`
	//var itemID uint32
	for _, v := range order.Items {
		tag, err := tx.Exec(ctx, query, orderID, v.ItemID, v.Quantity, v.Price)
		_ = tag
		if err != nil {
			return 0, err
		}
	}

	err = tx.Commit(ctx)
	if err != nil {
		return 0, err
	}
	return orderID, nil
}

func (s *Service) orderDBSetStatus(ctx context.Context, status model.OrderNotification) (err error) {
	query := `UPDATE orders SET status=$1, detail=$2, approved_at=NOW() WHERE order_id=$3`
	rows, err := s.storage.DB.Query(ctx, query, status.Status, status.Detail, status.OrderID)
	if err != nil {
		return err
	}
	defer rows.Close()
	return nil
}
