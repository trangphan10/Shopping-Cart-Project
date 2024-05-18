import os
import requests
import json
import random
categories = "./categories/"
images = "./images/"
products = "./products/"
BACKEND_HOST = "127.0.0.1" if os.environ.get("BACKEND_HOST") != "backend-service" else "backend-service"
print(BACKEND_HOST)

link = "http://" + BACKEND_HOST + ":9000/"
def create_user(account):
    d = account.copy()
    d["firstname"] = "aaa"
    d["lastname"] = "nnnn"
    r = requests.post( link + 'register', json=d)
    print(r.json())

def create_category(path):
    dir_list = os.listdir(path)
    for i in dir_list:
        f = open(path+i)
        data = json.load(f)
        r = requests.post( link + 'categories', json=data)
        print(r.json())
        f.close

def create_product(path):
    dir_list = os.listdir(path)
    for i in dir_list:
        path_1 = path+i +"/"
        for j in os.listdir(path_1):
            path_2 = path_1+j
            # print(path_2)
            f = open(path_2)
            data = json.load(f)
            print(data)
            r = requests.post(f'{link}products', json=data)
            print(r.json())
            f.close

def add_item_to_cart(data):
    # dang nhap lay ra user id vaf tu do lay ra cart_id roi them cart item vaof
    r = requests.post(url = f'{link}login', json=data)
    user_id = r.json()["ID"]
    r = requests.get(url = f'{link}carts/{user_id}')

    products = requests.get(f"{link}products").json()
    cart = r.json()
    n = random.randint(1, len(products))

    data = {
                "CartID": cart["ID"],
                "productID": products[n-1]["ID"],
                "Qty" : 10
            }
    
    r = requests.post(url = f'{link}carts', json=data)
    r = requests.get(url = f'{link}carts/{user_id}')
    print( json.dumps(r.json(), indent=2))
    return

def create_order(data):
    r = requests.post(url = f'{link}login', json=data)
    user_id = r.json()["ID"]
    print(user_id)
    r = requests.get(url = f'{link}carts/{user_id}')

    data = {
                "UserID" : user_id,
                "OrderItems" : [],
                "Code" : "abcdef",
                "Status" : 1,
                "BaseTotalPrice" : 0.0,
                "ShippingCost" : 100,
                "Note" : "hello"
            }
    order_item_data =  {
                            "ProductID" : "",
                            "Qty" : 0,
                            "BasePrice" : 0,
                            "BaseTotal" : 0
                        }
    
    
    cart = r.json()
    cart_items = cart["CartItems"]
    for i in cart_items:
        item_data = order_item_data.copy()
        item_data["ProductID"] = i["ProductID"]
        item_data["Qty"] = i["Qty"]
        item_data["BasePrice"] = i["BasePrice"]
        item_data["BaseTotal"] = i["BaseTotal"]

        data["OrderItems"].append(item_data)
        data["BaseTotalPrice"] += eval(item_data["BaseTotal"])
    print(data)
    r = requests.post(url= f"{link}orders", json=data)
    print( json.dumps(r.json(), indent=2))
    return

def main():
    data = {
                "email" : "aaa@a.a",
                "password" : "b"
            }
    create_user(data)
    create_category(categories)
    create_product(products)
    
    add_item_to_cart(data)
    create_order(data=data)
    return

if __name__ == "__main__":
    main()

