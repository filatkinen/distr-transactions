package model

import (
	"time"
)

type Order struct {
	OrderID      uint32
	UserID       uint32
	Payment      PaymentType
	Notification NotificationType
	CreatedAt    time.Time
	ApprovedAt   time.Time
	Sum          uint32
	SumDecimal   uint32
	Items        []OrderItem
	Status       OrderStatus
}

type OrderNotification struct {
	OrderID uint32
	Status  OrderStatus
}

type ServiceNotification struct {
	OrderID uint32
	Status  ServiceDetailedStatus
}

type OrderItem struct {
	ItemID       uint32
	Price        uint32
	PriceDecimal uint32
}
