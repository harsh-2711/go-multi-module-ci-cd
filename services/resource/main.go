package main

import (
	"fmt"
	"log"

	"github.com/harsh-2711/go-multi-module-ci-cd/packages/odd"
)

func main() {
	fmt.Println("input resourceId:")
	var resourceId int
	_, err := fmt.Scanln(&resourceId)
	if err != nil {
		log.Fatal(err)
	}

	if odd.IsOdd(resourceId) {
		fmt.Println("odd")
	} else {
		fmt.Println("even")
	}
}
