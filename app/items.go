package app

import (
	"math"

	"github.com/brianvoe/gofakeit"
	"gitlab.com/reenue/graphql-server/model"
)

func itemsFactory() *model.Item {
	types := []model.DiscountType{
		model.DiscountTypeFixed,
		model.DiscountTypePercent,
	}

	item := &model.Item{
		Name:         gofakeit.Name(),
		Renewable:    gofakeit.Bool(),
		ListPrice:    gofakeit.Float64Range(10, 1000),
		Quantity:     gofakeit.Number(1, 1000),
		Discount:     math.Round(gofakeit.Float64Range(1.0, 10.0)*100) / 100,
		DiscountType: types[gofakeit.Number(0, len(types)-1)],
	}

	item.Sum()

	return item
}
