package models

type Model struct {
	Model interface{}
}

func RegisterModels() []Model {
	return []Model{
		{Model: User{}},
		{Model: Product{}},
		{Model: ProductImage{}},
		{Model: Category{}},
		{Model: Order{}},
		{Model: OrderItem{}},
		{Model: OrderCustomer{}},
		{Model: Payment{}},
		{Model: Shipment{}},
		{Model: Cart{}},
		{Model: CartItem{}},
	}
}