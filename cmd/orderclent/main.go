package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/filatkinen/distr-transactions/internal/model"
	"log"
	"net/http"
	"time"
)

func main() {
	var order = model.Order{
		OrderID:      0,
		UserID:       2,
		Payment:      1,
		Notification: 1,
		CreatedAt:    time.Now(),
		ApprovedAt:   time.Now(),
		Sum:          10000,
		Items: append([]model.OrderItem(nil), model.OrderItem{
			ItemID:   10,
			Quantity: 2,
			Price:    45,
		}, model.OrderItem{
			ItemID:   15,
			Quantity: 1,
			Price:    10,
		}),
		Status: 1,
	}

	body, err := json.Marshal(&order)
	if err != nil {
		log.Fatal(err)
	}

	resp, err := http.Post("http://localhost:8180/neworder", "application/json",
		bytes.NewBuffer(body))
	if err != nil {
		log.Fatal(err, "error resp")
	}
	defer resp.Body.Close()

	buf := bytes.Buffer{}
	_, err = buf.ReadFrom(resp.Body)
	if err != nil {
		log.Println(err, "error buf")
		return
	}
	fmt.Println(buf.String())
	//var status model.OrderNotification
	//dec := json.NewDecoder(resp.Body)
	//err = dec.Decode(&status)
	//if err != nil {
	//	log.Println(err, "err decode")
	//	return
	//}
	//fmt.Println(status)

}
