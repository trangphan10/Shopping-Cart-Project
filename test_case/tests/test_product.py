import unittest
import source.product as product

class TestCategory(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        # Hàm này chạy trước tất cả các test cases trong class
        print("Setting up class...")

    @classmethod
    def tearDownClass(cls):
        # Hàm này chạy sau tất cả các test cases trong class
        print("Tearing down class...")

    
    def setUp(self):
        self.product = product.Product()
        print("set up category")

    def tearDown(self):
        if(self.product.id != ""):
            r = self.product.delete_product()
            print(r)
            all_product = self.product.get_all_product()
            check_delete_product = any(item["ID"] == self.product.id for item in all_product)
            self.assertFalse(check_delete_product)
        
        print("Tearing down test...")

    def test_get_all_product(self):
        print("====================test_get_all_product==================")
        all_product = self.product.get_all_product()
        print(all_product)
        self.assertTrue(len(all_product)>=1)

    def test_creat_product(self):
        print("====================test_creat_product==================")
        self.product.post_new_product()
        all_product = self.product.get_all_product()
        check_new_product = any(item["Name"] == "mouse test product" for item in all_product)
        self.assertTrue(check_new_product)

    def test_delete_product(self):
        print("====================test_delete_product==================")
        self.product.post_new_product()
        print(self.product.id)
        r = self.product.delete_product()
        print(r)
        all_product = self.product.get_all_product()
        check_delete_product = any(item["ID"] == self.product.id for item in all_product)
        self.assertFalse(check_delete_product)


    def test_put_update_product(self):
        print("====================test_update_product==================")
        self.product.post_new_product()
        self.product.data["Weight"] = 0.7
        r = self.product.put_update_product()
        print(r)
        all_product = self.product.get_all_product()
        w = -1
        for item in all_product:
            if item["ID"] == self.product.id:
                print("Item = ",item)
                w = item.get("Weight")
        print("W = ",w)
        self.assertTrue(w == "0.7")


    def test_product_by_id(self):
        self.product.post_new_product()
        data = self.product.get_product_by_id()
        self.assertTrue(len(data)>1 )
        self.assertTrue(data.get("ID") == self.product.id)
