package kafka

import (
	"errors"
	"github.com/IBM/sarama"
	"log/slog"
	"sync"
)

type Consumer struct {
	log    *slog.Logger
	config *sarama.Config

	connString string
	topic      string

	funcMessage func(*sarama.ConsumerMessage)

	// called if Config.Consumer.Return.Errors = true
	funcMessageError func(*sarama.ConsumerError)

	consumer  sarama.Consumer
	wg        sync.WaitGroup
	closeChan chan struct{}
}

func NewConsumer(config *sarama.Config,
	log *slog.Logger,
	connString string,
	topic string,
	funcMessage func(*sarama.ConsumerMessage),
	funcMessageError func(*sarama.ConsumerError)) (*Consumer, error) {

	con, err := sarama.NewConsumer([]string{connString}, config)
	if err != nil {
		return nil, err
	}
	return &Consumer{
		log:              log,
		config:           config,
		connString:       connString,
		topic:            topic,
		funcMessage:      funcMessage,
		funcMessageError: funcMessageError,
		consumer:         con,
		closeChan:        make(chan struct{}),
	}, nil
}

// offset=sarama.OffsetOldest or sarama.OffsetNewest
func (c *Consumer) ConsumeMessage(offset int64) error {
	partitionList, err := c.consumer.Partitions(c.topic)
	if err != nil {
		return err
	}
	counter := 0
	for _, partition := range partitionList {
		partitionConsumer, err := c.consumer.ConsumePartition(c.topic, partition, offset)
		if err != nil {
			c.log.Error("cannot get partitionConsumer:", partition, err)
			continue
		}
		counter++
		c.wg.Add(1)
		go func(partitionConsumer sarama.PartitionConsumer) {
			defer c.wg.Done()
			for {
				select {
				case consumeError := <-partitionConsumer.Errors():
					c.funcMessageError(consumeError)
				case msg := <-partitionConsumer.Messages():
					c.funcMessage(msg)
				case <-c.closeChan:
					return
				}
			}
		}(partitionConsumer)
	}
	if counter == 0 {
		return errors.New("Cannot start processing to any partition")
	}
	return nil
}

func (c *Consumer) Close() error {
	close(c.closeChan)
	c.wg.Wait()
	return c.consumer.Close()
}
