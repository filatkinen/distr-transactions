package kafka

import (
	"context"
	"errors"
	"fmt"
	"github.com/IBM/sarama"
	"log"
	"log/slog"
	"strings"
	"sync"
)

type RebalanceGroup uint

const (
	RebalanceGroupSticky     RebalanceGroup = 1
	RebalanceGroupRoundRobin RebalanceGroup = 2
	RebalanceGroupRange      RebalanceGroup = 3
)

type ConsumerGroup struct {
	log *log.Logger

	connString string
	group      string
	topics     string

	funcMessage func(*sarama.ConsumerMessage)
	// called if Config.consumerHandler.Return.Errors = true
	funcMessageError func(error)

	client sarama.ConsumerGroup

	ctx       context.Context
	cancel    context.CancelFunc
	wg        sync.WaitGroup
	closeChan chan struct{}
}

func NewConsumerGroup(
	confSarama func() *sarama.Config,
	logHandler slog.Handler,
	logVerbose bool,
	connString string,
	group string,
	topics string,
	rebalanceGroup RebalanceGroup,
	initOffset int64,
	clientID string,
	funcMessage func(message *sarama.ConsumerMessage),
	funcError func(message error)) (*ConsumerGroup, error) {

	if len(connString) == 0 || len(group) == 0 || len(topics) == 0 {
		return nil, errors.New("empty connString or group or topics")
	}

	if funcMessage == nil {
		return nil, errors.New("empty funcMessage")
	}

	if logHandler == nil {
		return nil, errors.New("empty slog.handler")
	}
	logger := slog.NewLogLogger(logHandler, slog.LevelInfo)
	if logVerbose {
		sarama.Logger = logger
	}

	config := confSarama()
	if funcError != nil {
		config.Consumer.Return.Errors = true
	}

	if initOffset != sarama.OffsetOldest && initOffset != sarama.OffsetNewest {
		return nil, errors.New("offset can be only sarama.OffsetOldest or sarama.OffsetNewes")
	}

	config.Consumer.Offsets.Initial = initOffset

	switch rebalanceGroup {
	case RebalanceGroupSticky:
		config.Consumer.Group.Rebalance.GroupStrategies = []sarama.BalanceStrategy{sarama.NewBalanceStrategySticky()}
	case RebalanceGroupRoundRobin:
		config.Consumer.Group.Rebalance.GroupStrategies = []sarama.BalanceStrategy{sarama.NewBalanceStrategyRoundRobin()}
	case RebalanceGroupRange:
		config.Consumer.Group.Rebalance.GroupStrategies = []sarama.BalanceStrategy{sarama.NewBalanceStrategyRange()}
	default:
		return nil, errors.New("wrong  assignator value for rebalanceGroup")
	}

	config.ClientID = clientID

	ctx, cancel := context.WithCancel(context.Background())
	client, err := sarama.NewConsumerGroup(strings.Split(connString, ","), group, config)
	if err != nil {
		cancel()
		return nil, fmt.Errorf("error creating consumer group client: %v", err)
	}

	consumerGroup := &ConsumerGroup{
		log:              logger,
		connString:       connString,
		group:            group,
		topics:           topics,
		funcMessage:      funcMessage,
		funcMessageError: funcError,
		client:           client,
		ctx:              ctx,
		cancel:           cancel,
		closeChan:        make(chan struct{}),
	}
	return consumerGroup, nil
}

func (cg *ConsumerGroup) MessageConsumeStart() error {
	consumer := consumerHandler{
		ready:       make(chan bool),
		funcMessage: cg.funcMessage,
		log:         cg.log,
	}

	if cg.funcMessageError != nil {
		cg.wg.Add(1)
		go func() {
			defer cg.wg.Done()
			for {
				select {
				case <-cg.ctx.Done():
					return
				case err := <-cg.client.Errors():
					cg.funcMessageError(err)
				}
			}
		}()
	}
	for {
		cg.wg.Add(1)
		go func() {
			defer cg.wg.Done()
			for {
				select {
				case <-cg.ctx.Done():
					return
				case <-consumer.ready:
					cg.log.Printf("kafka consumer up and running...\n")
					return
				}
			}
		}()

		if err := cg.client.Consume(cg.ctx, strings.Split(cg.topics, ","), &consumer); err != nil {
			if errors.Is(err, sarama.ErrClosedConsumerGroup) {
				return fmt.Errorf("error from consumer: %v", err)
			}
			cg.log.Printf("client.Consume got error:%v", err)
		}
		if cg.ctx.Err() != nil {
			return nil
		}
		consumer.ready = make(chan bool)
	}
}

func (cg *ConsumerGroup) MessageConsumePause() {
	cg.client.PauseAll()
}

func (cg *ConsumerGroup) MessageConsumeResume() {
	cg.client.ResumeAll()
}

func (cg *ConsumerGroup) MessageConsumeStop() {
	cg.cancel()
	cg.wg.Wait()
}

func (cg *ConsumerGroup) Close() error {
	err := cg.client.Close()
	return err
}
