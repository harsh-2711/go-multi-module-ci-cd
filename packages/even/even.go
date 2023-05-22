package even

import "fmt"

func IsEven(i int) bool {
	fmt.Println("IsEven func called") // to test auto dependency management of Golang
	return i%2 == 0
}
