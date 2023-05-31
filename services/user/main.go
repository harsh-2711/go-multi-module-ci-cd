package main

import (
	"fmt"
	"log"

	"github.com/harsh-2711/go-multi-module-ci-cd/packages/even"
	"github.com/harsh-2711/go-multi-module-ci-cd/services/resource/entity"
)

func main() {
	fmt.Println("input userId: ")
	var userId int
	_, err := fmt.Scanln(&userId)
	if err != nil {
		log.Fatal(err)
	}

	if even.IsEven(userId, false) {
		fmt.Println("even")
	} else {
		fmt.Println("odd")
	}

	userEntityId := entity.GetUserEntity(userId)
	fmt.Println("userEntityId: ", userEntityId)
}
