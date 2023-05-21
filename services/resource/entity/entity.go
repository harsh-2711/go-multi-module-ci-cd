package entity

import (
	"fmt"
	"math"
)

func GetUserEntity(userId int) int {
	fmt.Println("function called: GetUserEntity") // to test auto dependency management of Golang
	return int(math.Pow(float64(userId), 2))
}
