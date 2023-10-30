package service

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/filatkinen/distr-transactions/internal/model"
)

func (s *Service) dbOrderAdd(ctx context.Context, order model.Order) (orderID uint32, err error) {
	fail := func(err error) (uint32, error) {
		return 0, fmt.Errorf("CreateOrder: %v", err)
	}

	b, err := json.Marshal(order.Items)
	if err != nil {
		return fail(err)
	}

	query := `INSERT INTO orders (order_id, user_id, notification_type, created_at, approved_at, sum, status, order_items)
				VALUES ($1,$2,$3,$4,$5,$6,$7,$8)`
	_, err = s.storage.DB.Exec(ctx, query, order.OrderID, order.UserID, order.Notification,
		order.CreatedAt, order.ApprovedAt, order.Sum, b)
	if err != nil {
		return fail(err)
	}

	return order.OrderID, nil
}

func (s *Service) dbOrderAddStatusService(ctx context.Context, sn model.ServiceNotification) (err error) {
	query := `INSERT INTO service_status(order_id, service_id, status_at, status, detail) 
		VALUES ($1,$2,$3,$4,$5)`
	_, err = s.storage.DB.Exec(ctx, query, sn.OrderID, sn.ServiceID, sn.StatusAt, sn.Status, sn.Detail)
	return err
}

func (s *Service) dbOrderGet(ctx context.Context, orderID uint32) (order model.Order, err error) {
	var b []byte
	query := `SELECT order_id,
       user_id,
       notification_type,
       created_at,
       approved_at,
       sum,
       status,
       order_items
FROM order_new
WHERE order_id = $1`
	err = s.storage.DB.QueryRow(ctx, query, orderID).Scan(&order.OrderID, &order.UserID,
		&order.Notification, &order.CreatedAt, &order.ApprovedAt, &order.Sum, &order.Status, &b)
	if err != nil {
		return model.Order{}, err
	}

	var items []model.OrderItem
	err = json.Unmarshal(b, &items)
	if err != nil {
		return model.Order{}, err
	}

	order.Items = append(order.Items, items...)
	return order, nil
}

func (s *Service) dbOrderGetStatusesAsString(ctx context.Context, orderID uint32) (status string, err error) {
	query := `SELECT order_id, service_id, status_at, status, detail FROM service_status WHERE order_id=$1`
	rows, err := s.storage.DB.Query(ctx, query, orderID)
	if err != nil {
		return "", err
	}
	defer rows.Close()

	var stat model.ServiceNotification
	var stats []model.ServiceNotification
	for rows.Next() {
		err = rows.Scan(
			&stat.OrderID,
			&stat.ServiceID,
			&stat.StatusAt,
			&stat.Status,
			&stat.Detail,
		)
		if err != nil {
			return "", err
		}
		stats = append(stats, stat)
	}
	if err := rows.Err(); err != nil {
		return "", err
	}

	if len(stats) == 0 {
		return "", nil
	}

	b, err := json.Marshal(stats)
	if err != nil {

	}
	status = string(b)
	return status, err
}
