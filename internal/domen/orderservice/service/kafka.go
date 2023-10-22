package service

import (
	"fmt"
	"github.com/IBM/sarama"
)

func (s *Service) KafkaGetMessage(message *sarama.ConsumerMessage) {
	fmt.Printf("Message claimed: value = %s, topic = %s, partition%d, offset:%d\n",
		string(message.Value), message.Topic, message.Partition, message.Offset)
}

func (s *Service) KafkaGetError(err error) {
	fmt.Printf("got error:%v\n", err)
}
