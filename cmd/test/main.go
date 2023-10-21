package main

import "fmt"

func main() {
	ch := make(chan int, 1)
	n, _ := <-ch
	fmt.Println(n)
}
