package model

type PaymentType uint8

type NotificationType uint8

type OrderStatus uint8

type ServiceStatus uint8

type ServiceID uint8

type InvoiceType uint8

type ServiceDetailedStatus struct {
	ServiceStatus ServiceStatus
	Detail        string
}
