import unittest
import source.category as cate

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
        self.category = cate.Category("test_id01","name_test01")
        print("set up category")

    def tearDown(self):

        self.category.delete_category()
        print("Tearing down test...")

    def test_get_cart(self):
        print("====================test_get_cart==================")
        category_temp = self.category.get_category()
        print(category_temp)
        self.assertTrue(len(category_temp)>=1)

    def test_creat_category_01(self):
        print("====================test_creat_category_01==================")
        self.category.post_new_category()
        category_temp = self.category.get_category()
        print(category_temp)
        check_new_category = any(item["ID"] == "test_id01" for item in category_temp)
        self.assertTrue(check_new_category)

    def test_delete_category(self):
        self.category.post_new_category()
        print("====================test_delete_category==================")
        r = self.category.delete_category()
        category_temp = self.category.get_category()
        print(r)
        check_new_category = any(item["ID"] == "test_id01" for item in category_temp)
        self.assertFalse(check_new_category)


    def test_get_category_by_id_01(self):
        self.category.post_new_category()
        print("===============test_get_category_by_id_01===========")
        category_temp = self.category.get_category_by_id()
        print(category_temp)
        check_id_category = (category_temp["ID"] == "test_id01")
        self.assertTrue(check_id_category)

    def test_put_update_category(self):
        self.category.post_new_category()
        self.category.put_update_category("new_name1_update")
        category_temp = self.category.get_category()
        print(category_temp)
        check_new_name = any(item["Name"] == "new_name1_update" for item in category_temp)
        self.assertTrue(check_new_name)

