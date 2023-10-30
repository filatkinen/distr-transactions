package main

import (
	"encoding/json"
	"fmt"
)

type OrderItem struct {
	ItemID   uint32 `json:"item_id"`
	Quantity uint32 `json:"quantity"`
	Price    uint32 `json:"price"`
}

type a struct {
	num []byte
}

type SetService struct {
	Mistakes int `json:"mistakes"` // mistakes persent
}

func main() {

	s := SetService{Mistakes: 10}
	b, _ := json.Marshal(s)
	fmt.Println(b)
	fmt.Println(string(b))

	k := a1()
	fmt.Println(k)
}

func a1() a {
	b1 := []byte{1, 2, 4}
	return a{b1}
}
