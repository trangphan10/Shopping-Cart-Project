package models

import (
	"fmt"
	"time"

	"github.com/google/uuid"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
)

type Product struct {
	ID            string `gorm:"size:36;not null;uniqueIndex;primary_key"`
	CategoryID    string `gorm:"foreignKey:CategoryID"`
	ProductImages []ProductImage
	Category      *Category
	Cartitems     []CartItem
	OrderItems    []OrderItem
	Sku           string          `gorm:"size:100;index"`
	Name          string          `gorm:"size:255"`
	Price         decimal.Decimal `gorm:"type:decimal(16,2);"`
	Stock         int
	Weight        decimal.Decimal `gorm:"type:decimal(10,2);"`
	Description   string          `gorm:"type:text"`
	Status        int             `gorm:"default:0"`
	CreatedAt     time.Time
	UpdatedAt     time.Time
	DeletedAt     gorm.DeletedAt
}

func (p *Product) GetProducts(db *gorm.DB) (*[]Product, error) {
	var err error
	var products []Product
	// preload must be simillar to the attribute name in struct not the name of struct
	err = db.Debug().Preload("ProductImages").Model(&Product{}).Order("created_at desc").Find(&products).Error
	if err != nil {
		return nil, err
	}

	return &products, nil
}

func (p *Product) FindByID(db *gorm.DB, productID string) (*Product, error) {
	var err error
	var product Product

	err = db.Debug().Preload("Category").Preload("ProductImages").Model(&Product{}).Where("id = ?", productID).First(&product).Error
	if err != nil {
		return nil, err
	}

	return &product, nil
}

func (p *Product) CreateProduct(db *gorm.DB) error {
	var err error
	p.ID = uuid.New().String()
	for _, img := range p.ProductImages {
		img.BeforeCreate(db)
		img.ProductID = p.ID
	}

	err = db.Debug().Create(&p).Error
	if err != nil {
		return err
	}

	return nil
}

func (p *Product) DeleteProduct(db *gorm.DB, productID string) (*Product, error) {
	var pro Product
	// var img []ProductImage
	// var cart_item CartItem
	// var order_item OrderItem

	err := db.Debug().Preload("ProductImages").
		Preload("OrderItems").
		Preload("Cartitems").
		Model(&Product{}).Where("ID=?", productID).First(&pro).Error
	if err != nil {
		return nil, err
	}

	// db.Debug().Model(&CartItem{}).Where("product_id = ?", productID).Unscoped().Delete(&cart_item)
	// db.Debug().Model(&OrderItem{}).Where("product_id = ?", productID).Unscoped().Delete(&order_item)
	// db.Debug().Model(&ProductImage{}).Where("product_id = ?", productID).Unscoped().Delete(&img)
	// fmt.Println(pro)
	fmt.Println(len(pro.ProductImages) == 0)
	if len(pro.Cartitems) != 0 {
		db.Debug().Unscoped().Delete(&pro.Cartitems)
	}

	if len(pro.OrderItems) != 0 {
		db.Debug().Unscoped().Delete(&pro.OrderItems)
	}

	if len(pro.ProductImages) != 0 {
		db.Debug().Unscoped().Delete(&pro.ProductImages)
	}
	
	// db.Debug().Unscoped().Delete(&pro.OrderItems)
	// db.Debug().Unscoped().Delete(&pro.ProductImages)
	
	db.Debug().Unscoped().Delete(&pro)

	return &pro, nil
}

func (p *Product) UpdateProduct(db *gorm.DB, productID string) (*Product, error) {
	db.Debug().Model(&Product{}).Where("id = ?", productID).Updates(&p)
	return p.FindByID(db, productID)
}
