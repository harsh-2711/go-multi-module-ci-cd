package odd

import (
	"fmt"

	"github.com/harsh-2711/go-multi-module-ci-cd/packages/even"
)

func IsOdd(i int) bool {
	fmt.Println("IsOdd function called") // to test auto dependency management of Golang
	return !even.IsEven(i, true)
}
