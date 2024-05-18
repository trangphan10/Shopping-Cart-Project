import requests

class User:
    def __init__(self, email, password, first_name = "", last_name = "", address = ""):
        self.data = {
            "firstname" : first_name,
            "lastname" : last_name,
            "email" : email,
            "password" : password,
            "address" : address
        }


        self.id = ""

        self.is_login = False

    def register(self):
        # Logic để đăng ký người dùng
        # print(self.data)
        r = requests.post(url="http://localhost:9000/register", json=self.data)
        if r.status_code == 200:
            return r.json()
        
        raise requests.HTTPError
            
            

    def login(self):
        r = requests.post(url="http://localhost:9000/login", json=self.data)
        if r.status_code == 200:
            response = r.json()

            if len(response) > 1:
                self.id = response["ID"]
                self.is_login = True
            return r.json()
        
        raise requests.HTTPError

    def logout(self):
        self.id = ""
        self.is_login = False
        print(f"User {self.data['email']} has been logged out.")

    def delete_user(self, user_id):
        # Logic để xóa người dùng
        print(user_id)
        r = requests.delete(url=f"http://127.0.0.1:9000/users/{user_id}")
        if r.status_code == 200:
            return r.json()
        
        raise requests.HTTPError

    def get_user(self, user_id):
        # Trả về thông tin người dùng
         
        r = requests.get(url=f"http://127.0.0.1:9000/users/{user_id}")
        if r.status_code == 200:
            return r.json()
        
        raise requests.HTTPError


    def update_user(self, user_id, new_password=None, new_first_name=None, new_last_name=None, new_add = None):
        # Cập nhật thông tin người dùng
        data_temp = {}
        if new_password:
            data_temp["password"] = new_password
        if new_first_name:
            data_temp["firstname"] = new_first_name
        if new_last_name:
            data_temp["lastname"] = new_last_name
        if new_add:
            data_temp["address"] = new_add

        if new_password:
            self.data["password"] = new_password
        if new_first_name:
            self.data["firstname"] = new_first_name
        if new_last_name:
            self.data["lastname"] = new_last_name
        if new_add:
            self.data["address"] = new_add
        
        # print(self.data_temp)


        r = requests.put(url=f"http://127.0.0.1:9000/users/{user_id}", json=data_temp)
        if r.status_code == 200:
            return r.json()
        
        raise requests.HTTPError

        