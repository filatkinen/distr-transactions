package model

import (
	"time"
)

type Order struct {
	OrderID      uint32           `json:"order_id"`
	UserID       uint32           `json:"user_id"`
	Payment      PaymentType      `json:"payment"`
	Notification NotificationType `json:"notification"`
	CreatedAt    time.Time        `json:"created_at"`
	ApprovedAt   time.Time        `json:"approved_at,omitempty"`
	Sum          uint32           `json:"sum"`
	Items        []OrderItem      `json:"items"`
	Status       OrderStatus      `json:"status"`
	Detail       string           `json:"detail"`
}

type OrderNotification struct {
	OrderID uint32      `json:"order_id"`
	Status  OrderStatus `json:"status"`
	Detail  string      `json:"detail"`
}

type ServiceNotification struct {
	OrderID   uint32        `json:"order_id"`
	ServiceID ServiceID     `json:"serviceID"`
	StatusAt  time.Time     `json:"status_at"`
	Status    ServiceStatus `json:"status"`
	Detail    string        `json:"detail"`
}

type OrderItem struct {
	ItemID   uint32 `json:"item_id"`
	Quantity uint32 `json:"quantity"`
	Price    uint32 `json:"price"`
}

type WarehouseMessage struct {
	OrderID uint32      `json:"order_id"`
	Items   []OrderItem `json:"items"`
}

type WarehouseMessageCancel struct {
	OrderID uint32 `json:"order_id"`
}

type PaymentMessage struct {
	OrderID uint32      `json:"order_id"`
	UserID  uint32      `json:"user_id"`
	Payment PaymentType `json:"payment"`
	Sum     uint32      `json:"sum"`
}

type NotificationMessage struct {
	OrderID      uint32           `json:"order_id"`
	UserID       uint32           `json:"user_id"`
	Notification NotificationType `json:"notification"`
}
