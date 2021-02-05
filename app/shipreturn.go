package app

import (
	"github.com/brianvoe/gofakeit/v4"
	"gitlab.com/reenue/graphql-server/model"
)

func accountFactory(domain string) *model.Account {
	return &model.Account{
		BusinessID: domain,
		Name:       gofakeit.Company(),
		Website:    gofakeit.DomainName(),
		Phone:      gofakeit.Phone(),
	}
}
