package models

import (
	"strings"
	"time"

	"github.com/google/uuid"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
)

type User struct {
	ID            string `gorm:"size:36;not null;uniqueIndex;primary_key"`
	Address       string
	Carts         *Cart
	FirstName     string `gorm:"size:100;not null"`
	LastName      string `gorm:"size:100;not null"`
	Email         string `gorm:"size:100;not null;uniqueIndex"`
	Password      string `gorm:"size:255;not null"`
	RememberToken string `gorm:"size:255;not null"`
	CreatedAt     time.Time
	UpdatedAt     time.Time
	DeletedAt     gorm.DeletedAt
}

func (u *User) FindByEmail(db *gorm.DB, email string) (*User, error) {
	var err error
	var user User
	// fmt.Println(email + "aaaaaaa")
	err = db.Debug().Model(User{}).Where("LOWER(email) = ?", strings.ToLower(email)).
		First(&user).
		Error
	if err != nil {
		return nil, err
	}

	return &user, nil
}

func (u *User) FindByID(db *gorm.DB, userID string) (*User, error) {
	var err error
	var user User

	err = db.Debug().Model(User{}).Omit("Password").Where("id = ?", userID).
		First(&user).
		Error
	if err != nil {
		return nil, err
	}

	return &user, nil
}

func (u *User) CreateUser(db *gorm.DB) (*User, error) {

	err := db.Debug().Create(&u).Error
	if err != nil {
		return nil, err
	}

	cart := &Cart{}
	cart.UserID = u.ID
	cart.ID = uuid.New().String()
	cart.BaseTotalPrice = decimal.NewFromInt(0)
	cart.CreateCart(db)

	return u, nil
}

func (u *User) RemoveUser(db *gorm.DB, userID string) (*User, error) {
	var user User
	err := db.Debug().Preload("Carts").
		Model(&User{}).Where("ID=?", userID).First(&user).Error
	if err != nil {
		return nil, err
	}

	user.Carts.ClearCart(db)
	order := &Order{}
	order.DeleteOrder(db, userID)
	
	db.Model(&User{}).Where("ID=?", userID).Unscoped().Delete(&user)

	return &user, nil
}

func (u *User) UpdateUser(db *gorm.DB, userID string) (*User, error) {
	db.Debug().Model(&User{}).Where("id = ?", userID).Updates(&u)
	return u.FindByID(db, userID)
}
