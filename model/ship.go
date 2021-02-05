package model

import (
	"time"

	validation "github.com/go-ozzo/ozzo-validation/v4"
	"github.com/google/uuid"
	"github.com/jinzhu/gorm"

	"github.com/leebenson/conform"
)

// Account defines the structure of an account that is the parent for opportunities
type Account struct {
	CreatedAt       time.Time          `json:"createdAt" gorm:"default:CURRENT_TIMESTAMP"`
	UpdatedAt       time.Time          `json:"updatedAt"`
	DeletedAt       *time.Time         `sql:"index"`
	id			string                 `json:"externalId"`
	name   string                 `json:"template"`
	class        string                 `json:"from,omitempty"`
	armament    []string               `json:"to"`
	crew          []string               `json:"cc,omitempty"`
	Data        map[string]interface{} `json:"data"`
	image		[]io.Reader            `json:"attachments,omitempty"`
	value        string                 `json:"text,omitempty"`
	status     string                 `json:"subject"`
}

// BeforeSave runs based on save using gorm
func (a *Account) BeforeSave(scope *gorm.Scope) error {
	return conform.Strings(a)
}

// BeforeCreate runs after before save but only when creating
func (a *Account) BeforeCreate(scope *gorm.Scope) error {
	uuid := uuid.Must(uuid.NewRandom()).String()
	scope.SetColumn("ID", uuid)

	return nil
}

// Validate the input is valid
func (a Account) Validate() error {
	return validation.ValidateStruct(&a,
		validation.Field(&a.Name, validation.Required, validation.Length(3, 75)),
	)
}

type AccountRates struct {
	Account             *Account `json:"account"`
	TotalValue          float64  `json:"totalValue"`
	ActiveOpportunities int      `json:"activeOpportunities"`
	AverageDifference   float64  `json:"averageDifference"`
}
