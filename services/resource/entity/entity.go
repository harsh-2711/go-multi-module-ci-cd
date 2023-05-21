package entity

import "math"

func GetUserEntity(userId int) int {
	return int(math.Pow(float64(userId), 2))
}
