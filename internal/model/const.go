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

func (s OrderStatus) String() string {
	str := ""
	switch s {
	case OrderStatusNotOk:
		str = "NOT OK"
	case OrderStatusOk:
		str = "OK"
	case OrderStatusProcess:
		str = "Process"
	case OrderStatusNew:
		str = "New"
	case OrderStatusCancel:
		str = "Canceled"
	}
	return str
}

func (s ServiceStatus) String() string {
	str := ""
	switch s {
	case ServiceStatusAk:
		str = "Accepted"
	case ServiceStatusNotOK:
		str = "NOT OK"
	case ServiceStatusOK:
		str = "OK"
	}
	return str
}
