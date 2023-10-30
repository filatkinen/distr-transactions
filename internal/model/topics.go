package model

const (
	TopicOrder       = "orders.service.order"
	TopicOrderStatus = "orders.service.status"

	TopicOrderWareHouse       = "orders.service.warehouse.reserv"
	TopicOrderWareHouseCancel = "orders.service.warehouse.cancel"
	TopicOrderWareHouseStatus = "orders.service.warehouse.status"

	TopicOrderPayment       = "orders.service.payment.pay"
	TopicOrderPaymentStatus = "orders.service.payment.status"

	TopicOrderNotification       = "orders.service.notification.send"
	TopicOrderNotificationStatus = "orders.service.notification.status"
)
