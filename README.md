# SE2023 - 15.1: Back-End mastering với các công nghệ CI/CD/Cloud hiện đại
![Build docker and run test case](https://github.com/tritam593/se15.1/actions/workflows/docker-image.yml/badge.svg)
![Deploy to k8s](https://github.com/tritam593/se15.1/actions/workflows/k8s.yml/badge.svg)
# Nội dung 
- Tự động triển khai dự án phần mềm với Github Action
- Nghiên cứu docker/k8s, triển khai một dịch vụ đơn giản.
- SV cùng mentor xây dựng đề bài và giải quyết vấn đề.
# Đề bài: Xây dụng một trang web ecommerce 
(**Lưu ý:** do project của chúng em sử dụng docker và k8s lên nếu chạy file index.html trong frontend sẽ bị lỗi một số chức năng do chúng em phải tinh chỉnh file js cho phù hợp với k8s)
Trong bài làm của chúng em thì chúng em sẽ tạo một trang web đơn giản mà trong đó trang web có sẵn các sản phẩm và người dùng chỉ cần đăng kí tài khoản, sau đó thì thêm sản phẩm vào giỏ hàng rồi sau đó thanh toán đơn hàng ( chúng em làm gần giống với cả trang web bán hàng của nike ạ (https://www.nike.com/vn/)). **(Ở đây chúng em làm có thể thiếu một số chức năng do chúng em còn thiếu một vài kiến thức nhất định ạ)**
![Alt text](image_demo.png)
# Các yêu cầu để chạy được repo này
- Cài đặt Docker và K8s
- Cài đặt python3 
- Cài đặt các thư cần thiết của python được ghi trong file requirements.txt

# Các bước để chạy được repo này
- Clone repo về máy: ```git clone https://github.com/tritam593/se15.1.git```
- Change directory to repo folder: ```cd se15.1```
- Change directory to backend folder: ```cd backend```
- Chạy hai command sau để build docker image: 
		
		docker build -t backend-golang --target program .
		
		docker build -t mysql-db --target db .
		
- Change directory to frontend folder: ```cd ../frontend```
- Chạy command command sau để build docker image: 

		docker build -t frontend .
- Change directory to se15.1 folder: ```cd ..```
- Chạy các command sau để chạy k8s (**Lưu ý:** sau khi chạy xong thì nên đợi khoảng tầm 1-2 phút để database container khởi tạo hoàn tất)

		
		kubectl apply -f backend/database-deployment.yaml 
		kubectl apply -f backend/database-service.yaml 
		kubectl apply -f backend/backend-deployment.yaml 
		kubectl apply -f backend/backend-service.yaml 
		kubectl apply -f frontend/frontend-deployment.yaml 
		kubectl apply -f frontend/frontend-service.yaml 
		
- Sau đó mở một browser bất kì và truy cập: ```http://localhost:32410/```

# Test case
Trong project này, chúng em có tạo các test case để test chức năng của sever. Các test case chúng em để trong thư mục test_case của repo.

- Các bước để run test case (**Lưu ý:** Nếu chưa cài đặt các thư viện trong file requirements.txt thì chạy lệnh sau ```pip install -r requirements.txt```)
	- Chạy docker-compose file : ( sau khi chạy thì đợi khoảng tầm 2p để khởi tạo database container và để server connect tới database)
		```
		docker-compose up -d 
		```	
	- khởi tạo data (vì có một số test case cần sử dụng data có sẵn)
		```
		cd fake-data
		python3 fake.py
		cd ..
		```
	- Change directory to test_case folder: ```cd test_case```
	- Chạy các command sau để run test case bằng python (**python3 command với linux và python command với windown**)
	
		```
		python3 -m unittest tests.test_user
		python3 -m unittest tests.test_category
		python3 -m unittest tests.test_product
		python3 -m unittest tests.test_cart
		```
	
### Components

| No  | Name             | Description                                                                                             |                  |
| --- | ---------------- | ------------------------------------------------------------------------------------------------------- | ---------------- |
| 1   | Backend          | Golang REST API                                                                                         | Docker Container |
| 2   | Frontend         | nginx and html/css/js											                                       | Docker Container |
| 3   | Mysql database 	 | Mysql database                                                                                          | Docker Container |
| 4   | Kubernetes       | Deploy docker image into k8s                                                                            | Kubernetes       |


### CI Workflow

CI/CD Workflow sẽ kiểm tra khi push code lên  **tam-k8s-docker-CI-CD branch** hoặc tạo pull request để merge vào **main branch**

Workflow  step :
- Build docker and run test case:
	1. Build docker image bằng Dockerfile trong thư mục **backend** và **frontend**
	2. Chạy docker-compose file
	3. Cài đặt python
	4. Chạy các test case
	5. Dừng docker compose
- K8s:
	1. Build docker image bằng Dockerfile trong thư mục **backend** và **frontend**
	2. Chạy docker-compose file
	3. Cài đặt python
	4. Chạy các test case
	5. Dừng docker compose
	6. Sử dụng **kubectl** để tạo các **Deloyment** và **Service** bằng các file **yaml** trong thư mục **backend** và **frontend**
	7. Kiểm tra k8s có chạy được không 
	8. Dừng các **Deloyment** và **Service** 

# Người hướng dẫn và các thành viên trong nhóm
- Thầy Bùi Sỹ Nguyên - Người hướng dẫn
- Đoàn Đức Tài - MSV: 21001580
- Nguyễn Đồng Trí Tâm - MSV: 21001581 - Leader
- Đặng Đình Thắng - MSV: 21001586
- Phan Thị Thu Trang - MSV: 21001593
