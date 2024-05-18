package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"

	"github.com/shopspring/decimal"
)

type CartItem struct {
	ID        string `gorm:"size:36;not null;uniqueIndex;primary_key"`
	CartID    string `gorm:"size:36;index"`
	Product   Product
	ProductID string `gorm:"size:36;index"`
	Qty       int
	BasePrice decimal.Decimal `gorm:"type:decimal(16,2)"`
	BaseTotal decimal.Decimal `gorm:"type:decimal(16,2)"`
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (c *CartItem) BeforeCreate() error {
	if c.ID == "" {
		c.ID = uuid.New().String()
	}

	return nil
}

func (c *CartItem) CalculateCartItem(db *gorm.DB) error {
	product := &Product{}
	product, _ = product.FindByID(db, c.ProductID)
	c.BasePrice = product.Price
	basePrice, _ := c.BasePrice.Float64()
	c.BaseTotal = decimal.NewFromFloat(basePrice * float64(c.Qty))
	err := db.Debug().Model(CartItem{}).Where("id = ?", c.ID).Updates(&c).Error
	if err != nil {
		return err
	}
	return nil
}
