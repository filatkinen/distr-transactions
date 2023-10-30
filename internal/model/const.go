package model

const (
	PaymentTypeCard PaymentType = 1
	PaymentTypeSBP  PaymentType = 2

	NotificationTypeEmail NotificationType = 1
	NotificationTypeSMS   NotificationType = 2

	OrderStatusNew     OrderStatus = 1
	OrderStatusProcess OrderStatus = 2
	OrderStatusOk      OrderStatus = 3
	OrderStatusNotOk   OrderStatus = 4
	OrderStatusCancel  OrderStatus = 5

	ServiceStatusAk    ServiceStatus = 1
	ServiceStatusOK    ServiceStatus = 2
	ServiceStatusNotOK ServiceStatus = 3

	ServiceIDWarehouse    ServiceID = 1
	ServiceIDPayment      ServiceID = 2
	ServiceIDNotification ServiceID = 3
)
