package model

import (
	"database/sql/driver"
	"fmt"
	"io"
	"strconv"
	"time"

	"github.com/google/uuid"
	"github.com/jinzhu/gorm"

	validation "github.com/go-ozzo/ozzo-validation/v3"
	"github.com/go-ozzo/ozzo-validation/v3/is"
)

type UserStatus string

const (
	UserStatusPending   UserStatus = "PENDING"
	UserStatusActive    UserStatus = "ACTIVE"
	UserStatusSuspended UserStatus = "SUSPENDED"
)

var AllUserStatus = []UserStatus{
	UserStatusPending,
	UserStatusActive,
	UserStatusSuspended,
}

func (e UserStatus) IsValid() bool {
	switch e {
	case UserStatusPending, UserStatusActive, UserStatusSuspended:
		return true
	}
	return false
}

func (e UserStatus) String() string {
	return string(e)
}

func (e *UserStatus) UnmarshalGQL(v interface{}) error {
	str, ok := v.(string)
	if !ok {
		return fmt.Errorf("enums must be strings")
	}

	*e = UserStatus(str)
	if !e.IsValid() {
		return fmt.Errorf("%s is not a valid UserStatus", str)
	}
	return nil
}

func (e UserStatus) MarshalGQL(w io.Writer) {
	fmt.Fprint(w, strconv.Quote(e.String()))
}

func (e *UserStatus) Scan(value interface{}) error {
	*e = UserStatus(value.(string))
	return nil
}

func (e UserStatus) Value() (driver.Value, error) {
	return string(e), nil
}

////////////////
// USER MODEL //
////////////////

// User structure for Reenue
type User struct {
	ID         string     `json:"id" gorm:"type:uuid;primary_key;"`
	BusinessID string     `json:"-" gorm:"type:uuid"`
	Business   *Business  `json:"business"`
	FirstName  string     `json:"firstName"`
	LastName   string     `json:"lastName"`
	Email      string     `json:"email"`
	Status     UserStatus `json:"status"`
	Signature  *Signature `json:"signature"`
	Password   *Password  `json:"-" gorm:"polymorphic:Owner"`
	CreatedAt  time.Time  `json:"createdAt" gorm:"default:CURRENT_TIMESTAMP"`
	UpdatedAt  time.Time  `json:"updatedAt"`
	DeletedAt  *time.Time `sql:"index"`
}

// BeforeCreate runs before the user model is created.
// Creates a UUID and assigns it to the ID attribute
func (u *User) BeforeCreate(scope *gorm.Scope) error {
	uuid := uuid.Must(uuid.NewRandom()).String()
	scope.SetColumn("ID", uuid)

	if u.Status == "" {
		u.Status = UserStatusPending
	}

	return nil
}

// Validate the entry of the user
func (u User) Validate() error {
	return validation.ValidateStruct(&u,
		validation.Field(&u.FirstName, validation.Length(2, 30)),
		validation.Field(&u.LastName, validation.Length(2, 30)),
		validation.Field(&u.Email, validation.Required, is.Email),
	)
}
