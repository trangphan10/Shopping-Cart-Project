import unittest
import source.cart as cart
import source.user as user
import source.product as product


class TestCart(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        print("=================Start set up class==================")
        cls.user = user.User("testuser@example.com", "a", "Test", "User", "as,ndsalkdsalk")
        cls.product = product.Product()

        print("Data product: ",cls.product.data)
        print("Data user: ",cls.user.data)
        response = cls.user.register()
        print("User response",response)
        response2 = cls.product.post_new_product()
        print("Product respone",response2)
        assert 1 == len(response)
        assert "Check" in (response.keys())
        assert "ok" == response["Check"]
        print("=================END set up class==================")

    # test delete account
    @classmethod
    def tearDownClass(cls):
        print("===========Start tear down class===========")
        cls.user.login()
        print(cls.user.id)
        response = cls.user.delete_user(cls.user.id)
        print("DELETE USER ",response)
        response2 = cls.product.delete_product()
        print("DELETE PRODUCT ",response2)
        assert 1 == len(response)
        assert "Check" in (response.keys())
        assert "ok" == response["Check"]
        print("===========END tear down class===========")





    def setUp(self):
        # Khởi tạo một đối tượng User cho mỗi test case
        print("======STAR set up===============")
        response2 = self.user.login()
        id_user = response2["ID"]

        self.cart = cart.Cart(id_user)
        all_cart = self.cart.get_cart()
        self.cart.cart_item_id = all_cart["ID"]
        self.cart.data["CartID"] = self.cart.cart_item_id

        self.cart.product_id = self.product.id
        self.cart.data["productID"] = self.cart.product_id
        print("ID USER",self.cart.user_id)
        print("ID CARTS",self.cart.cart_item_id)
        print("ID PRODUCT",self.cart.product_id)
        print("======END set up ======")
    

    def test_get_cart(self):
        print("===============START test_get_cart============")
        cart_temp = self.cart.get_cart() 
        print(cart_temp)
        self.assertTrue(len(cart_temp) > 1)
        print("===============END test_get_cart==============")
        
        
    def test_add_item(self):
        print("====================STAR test_add_cart==================")
        #add
        self.cart.add_item()
        all_cart = self.cart.get_cart()
        #check
        check_add_cart = any(item["ProductID"] == self.cart.product_id for item in all_cart["CartItems"])

        #delete
        id_cart_item = [item["ID"] for item in all_cart["CartItems"]][0]
        self.cart.delete_item(id_cart_item)
        
        self.assertTrue(check_add_cart)
        print("====================END test_add_cart==================")


    def test_delete_item(self): 


        print("====================test_delete_cart==================")
        #add
        self.cart.add_item()
        all_cart = self.cart.get_cart()
        id_cart_item = [item["ID"] for item in all_cart["CartItems"]][0]


        #check delete
        self.cart.delete_item(id_cart_item)
        all_cart = self.cart.get_cart()
        check_delete_item = any(item["ProductID"] == id_cart_item for item in all_cart["CartItems"])

        self.assertFalse(check_delete_item)
        