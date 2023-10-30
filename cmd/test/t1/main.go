package main

import (
	"encoding/json"
	"fmt"
	"strings"
	"time"
)

type CustomTime struct {
	time.Time
}

const ctLayout = "2006/01/02|15:04:05"

func (ct *CustomTime) UnmarshalJSON(b []byte) (err error) {
	s := strings.Trim(string(b), "\"")
	if s == "null" {
		ct.Time = time.Time{}
		return
	}
	ct.Time, err = time.Parse(ctLayout, s)
	return
}

func (ct *CustomTime) MarshalJSON() ([]byte, error) {
	if ct.Time.IsZero() {
		return []byte("null"), nil
	}
	return []byte(fmt.Sprintf("\"%s\"", ct.Time.Format(ctLayout))), nil
}

var nilTime = (time.Time{}).UnixNano()

func (ct *CustomTime) IsSet() bool {
	return !ct.IsZero()
}

type Args struct {
	Time CustomTime
}

var data = `
    {"Time": "2014/08/01|11:27:18"}
`

func main() {
	a := Args{}
	json.Unmarshal([]byte(data), &a)
	fmt.Println(a)
	fmt.Println(a.Time.String())
}
