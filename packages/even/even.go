package even

import "fmt"

func IsEven(i int, shouldLog bool) bool {
	if shouldLog {
		fmt.Println("IsEven function called") // to test auto dependency management of Golang
	}
	return i%2 == 0
}
