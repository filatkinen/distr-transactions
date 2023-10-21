package kafka

import (
	"errors"
	"github.com/IBM/sarama"
	"log"
	"log/slog"
	"sync"
)

type Consumer struct {
	log    *log.Logger
	config *sarama.Config

	connString string
	topic      string

	funcMessage func(*sarama.ConsumerMessage)

	// called if Config.consumerHandler.Return.Errors = true
	funcMessageError func(*sarama.ConsumerError)

	consumer  sarama.Consumer
	wg        sync.WaitGroup
	closeChan chan struct{}
}

func NewConsumer(producerConfig func() *sarama.Config,
	logHandler slog.Handler,
	logVerbose bool,
	connString string,
	topic string,
	clientID string,
	funcMessage func(*sarama.ConsumerMessage),
	funcMessageError func(*sarama.ConsumerError)) (*Consumer, error) {

	if funcMessage == nil {
		return nil, errors.New("nil func for messages")
	}

	if logHandler == nil {
		return nil, errors.New("empty slog.handler")
	}
	logger := slog.NewLogLogger(logHandler, slog.LevelInfo)
	if logVerbose {
		sarama.Logger = logger
	}

	config := producerConfig()
	config.ClientID = clientID
	con, err := sarama.NewConsumer([]string{connString}, config)
	if err != nil {
		return nil, err
	}
	return &Consumer{
		log:              logger,
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
func (c *Consumer) ConsumeMessageStart(offset int64) error {
	partitionList, err := c.consumer.Partitions(c.topic)
	if err != nil {
		return err
	}
	counter := 0
	for _, partition := range partitionList {
		partitionConsumer, err := c.consumer.ConsumePartition(c.topic, partition, offset)
		if err != nil {
			c.log.Printf("cannot get partitionConsumer:", partition, err)
			continue
		}
		counter++
		c.wg.Add(1)
		go func(partitionConsumer sarama.PartitionConsumer) {
			defer c.wg.Done()
			for {
				select {
				case consumeError := <-partitionConsumer.Errors():
					if c.funcMessageError != nil {
						c.funcMessageError(consumeError)
					}
				case msg := <-partitionConsumer.Messages():
					c.funcMessage(msg)
				case <-c.closeChan:
					return
				}
			}
		}(partitionConsumer)
	}
	if counter == 0 {
		return errors.New("cannot start processing to any partition")
	}
	return nil
}

func (c *Consumer) ConsumeMessageStop() {
	close(c.closeChan)
	c.wg.Wait()
	c.closeChan = make(chan struct{})
}

func (c *Consumer) Close() error {
	close(c.closeChan)
	c.wg.Wait()
	return c.consumer.Close()
}
