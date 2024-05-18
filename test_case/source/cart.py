import requests
      
class Cart: 
    def __init__(self,user_id):
        self.user_id = user_id
        self.cart_item_id = ""
        self.product_id = ""
        
        self.data = {
            "CartID": self.cart_item_id,
            "productID": self.product_id,# san pham co san trong fake-data
            "Qty" : 19
        }
        
    def get_cart(self):
        r = requests.get(url=f"http://127.0.0.1:9000/carts/{self.user_id}")
        if r.status_code == 200: 
            self.user_cart = r.json()
            return self.user_cart
        
        raise requests.HTTPError
    
    def add_item(self):
        r = requests.post(url=f"http://127.0.0.1:9000/carts",json=self.data)
        if r.status_code == 200:
           return r.json()
        raise requests.HTTPError
        
    
    def delete_item(self,id_cart_item):
        print("====ID CART: ====",id_cart_item)
        r = requests.delete(url=f"http://127.0.0.1:9000/carts/{id_cart_item}")
        if r.status_code == 200:
           return r.json()
        raise requests.HTTPError
            
        
        