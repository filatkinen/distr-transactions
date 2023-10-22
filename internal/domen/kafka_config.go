package domen

type ProducerConfig struct {
	Topics     string
	ConnString string
	ClientID   string
	LogVerbose bool
}

type ConsumerConfig struct {
	Topics     string
	ConnString string
	ClientID   string
	LogVerbose bool
	Group      string
}
