import requests

class Category:
    def __init__(self,id_cate,name):
        self.data = {
            "ID" : id_cate,
            "Name" : name
        }

        self.id = id_cate
        self.category = []


    def get_category(self):
        r = requests.get(url=f"http://127.0.0.1:9000/categories")
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError
    

    def post_new_category(self):
        
        r = requests.post(url=f"http://127.0.0.1:9000/categories",json=self.data)
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError
    
    def delete_category(self):
        r = requests.delete(url=f"http://127.0.0.1:9000/categories/{self.id}")
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError
    
    def get_category_by_id(self):
        r = requests.get(url=f"http://127.0.0.1:9000/categories/{self.id}")
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError
    
    def put_update_category(self,new_name):
        self.data["Name"] = new_name
        r = requests.put(url=f"http://127.0.0.1:9000/categories/{self.id}",json=self.data)
        if r.status_code == 200:
            return r.json()
        raise requests.HTTPError