import unittest
import source.user as user



class TestUser(unittest.TestCase):

    # test register 
    @classmethod
    def setUpClass(cls):
        cls.user = user.User("testuser@example.com", "a", "Test", "User", "as,ndsalkdsalk")
        print(cls.user.data)
        response = cls.user.register()
        print(response)
        assert 1 == len(response)
        assert "Check" in (response.keys())
        assert "ok" == response["Check"]
        print("set up class")

    # test delete account
    @classmethod
    def tearDownClass(cls):

        cls.user.login()
        print(cls.user.id)
        response = cls.user.delete_user(cls.user.id)
        print(response)
        assert 1 == len(response)
        assert "Check" in (response.keys())
        assert "ok" == response["Check"]
        print("tear down class")

    def setUp(self):
        # Khởi tạo một đối tượng User cho mỗi test case
        self.user.login()
        print("====== set up ======")

    def tearDown(self) -> None:
        self.user.logout()
        print("====== tear down ======")

    # test for test case is the account already register befor
    def test_register(self):
        response = self.user.register()
        print("test register\n", response)
        self.assertEqual(1, len(response))
        self.assertTrue("Check" in (response.keys()))
        self.assertNotEqual("ok", response["Check"])

    # account is not exist
    def test_login(self):
        user_temp = user.User(email="1221@a.a", password="123")
        response = user_temp.login()
        print("test login\n", response)
        self.assertEqual(1, len(response))
        self.assertTrue("Check" in (response.keys()))
        self.assertNotEqual("ok", response["Check"])

    def test_logout(self):
        print("test logout")
        self.user.login()
        self.user.logout()
        self.assertTrue(self.user.is_login is False)

    def test_delete_user(self):
        # Cho mục đích minh họa, chạy phương thức delete_user không có thực
        response = self.user.delete_user("12345454")
        self.assertEqual(1, len(response))
        self.assertTrue("Check" in (response.keys()))
        self.assertTrue(response["Check"] == "Error")

    def test_update_user_01(self):
        response = self.user.update_user(user_id=self.user.id,
                               new_password="newpassword",
                                 new_last_name="NewName",
                                   new_first_name= "NewFirstName")
        print("test update user 01 \n", response)
        print(self.user.id)
        self.assertTrue(len(response) > 1)

    # update user not in database 
    def test_update_user_02(self):
        response = self.user.update_user(user_id="1214323",
                               new_password="newpassword",
                                 new_last_name="NewName",
                                   new_first_name= "NewFirstName")
        print("test update user 02 \n", response)
        self.assertTrue(len(response) == 1)
        self.assertTrue("Check" in (response.keys()))
        self.assertTrue(response["Check"] == "Error")


    # get infor of a user
    def test_get_user_01(self):
        print("test get user ")
        user_info = self.user.get_user(self.user.id)
        self.assertTrue(len(user_info) > 1)
        
        # print(self.user.data)
        output_info = {
            "firstname" : user_info["FirstName"],
            "lastname" : user_info["LastName"],
            "email" : user_info["Email"],
            "address" : user_info["Address"]
        }
        # print(output_info)
        expect_info = {
            "firstname" : self.user.data["firstname"],
            "lastname" : self.user.data["lastname"],
            "email" : self.user.data["email"],
            "address" : self.user.data["address"]
        }
        self.assertEqual(expect_info, output_info)

    # get info of user not in database
    def test_get_user_02(self):
        print("test get user ")
        user_info = self.user.get_user(1)
        self.assertTrue(len(user_info) == 1)
       