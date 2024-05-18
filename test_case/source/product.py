import requests

class Product:
    def __init__(self):
        self.data = {
                    "CategoryID": "mouse-123",
                    "ProductImages": [
                        {
                            "ID":"",
                            "Path": "+++++++++++++++++++++++"
                        },
                        {
                            "ID":"",
                            "Path": "++++++++++++++++++++++++++++"
                        }
                    ],
                    "Name": "mouse test product",
                    "Price": "300",
                    "Weight": 0.1,
                    "Description": "A high-quality mouse for people.",
                    "Status": 1
                }

        self.id = ""
        


    def get_all_product(self):
        r = requests.get(url=f"http://127.0.0.1:9000/products")
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError
    

    def post_new_product(self):
        
        r = requests.post(url=f"http://127.0.0.1:9000/products",json=self.data)
        all_product = self.get_all_product()
        self.id = next((item["ID"] for item in all_product if item["Name"] == "mouse test product"), None)
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError
    
    def delete_product(self):
        r = requests.delete(url=f"http://127.0.0.1:9000/products/{self.id}")
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError
    
    def get_product_by_id(self):
        r = requests.get(url=f"http://127.0.0.1:9000/products/{self.id}")
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError
    
    def put_update_product(self):
        r = requests.put(url=f"http://127.0.0.1:9000/products/{self.id}",json=self.data)
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError