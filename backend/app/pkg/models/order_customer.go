package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type OrderCustomer struct {
	ID        string `gorm:"size:36;not null;uniqueIndex;primary_key"`
	User      User
	UserID    string `gorm:"size:36;index"`
	Order     Order
	OrderID   string `gorm:"size:36;index"`
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (o *OrderCustomer) BeforeCreate() error {
	if o.ID == "" {
		o.ID = uuid.New().String()
	}

	return nil
}

func (o *OrderCustomer) DeleteOrderCustomer(db *gorm.DB, userID string) error{
	err := db.Debug().Model(&OrderCustomer{}).Where("user_id = ?", userID).Unscoped().Delete(&o).Error
	if err != nil {
		return err
	}
	return nil
}
