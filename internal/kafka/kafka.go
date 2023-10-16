package kafka

import "github.com/IBM/sarama"

type Broker struct {
}

func New() *Broker {
	sarama.new
}
