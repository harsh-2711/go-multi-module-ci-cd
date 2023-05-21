package odd

import "github.com/harsh-2711/go-multi-module-ci-cd/packages/even"

func IsOdd(i int) bool {
	return !even.IsEven(i)
}
