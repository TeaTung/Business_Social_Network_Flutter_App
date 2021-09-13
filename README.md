# Business_Social_Network_Flutter_App
### Git rules
+ Không push code lên branch master/main, chỉ được push và tạo pull request từ branch feature vào branch develop.
+ Commit và push code lên github trong khoảng thời gian từ 10h sáng đến 10h tối, không nhận bất kì lần pull request nào quá khoảng thời gian này.
+ 9h sáng mỗi ngày hoặc muốn code tiếp tục thì thực hiện update code trước tiên.
+ Mỗi feature sẽ tạo 1 branch mới.
+ Không được phép merge code.
### Hướng dẫn dùng Git Bash
#Bước 1: Clone Project
> git clone https://github.com/TeaTung/Health_Tracking_Android_App.git

hoặc

> git clone http://github.com/TeaTung/Health_Tracking_Android_App.git

![image](https://user-images.githubusercontent.com/67773933/115963852-8193a800-a54b-11eb-9fbd-e3a0b9833212.png)

#Bước 2: Kiểm tra các branch có trên máy và remote.

> git branch -a

![image](https://user-images.githubusercontent.com/67773933/115963974-4a71c680-a54c-11eb-8957-ba4da13af117.png)

#Bước 3: Thực hiện fetch branch develop trên remote (GitHub) về máy để code.
> git fetch origin develop

![image](https://user-images.githubusercontent.com/67773933/115964006-8573fa00-a54c-11eb-9dde-a99b51e44da1.png)

#Bước 4: Checkout sang nhánh develop.
> git chekout develop

![image](https://user-images.githubusercontent.com/67773933/115964039-b2281180-a54c-11eb-8bda-a3512ae6bc67.png)

Kể từ đây, mọi thao tác push và tạo pull request sẽ được push vào branch develop, không được phép thao tác thẳng lên master/main.

#Bước 5: Thực hiện checkout từ branch develop sang một branch feature để code phần của mình.
Mọi thao tác code sẽ được thực hiện trên chính branch này, push và pull request sẽ được đẩy vào branch develop, không được đẩy thẳng lên master/main
> git checkout -b feature/tasks_name

#Bước 6: Sau khi hoàn thành task, check status những gì đã làm.
> git status

![image](https://user-images.githubusercontent.com/67773933/115964200-7b9ec680-a54d-11eb-9b8a-2b944f47e44f.png)

#Bước 7: Sau khi review, add code và commit.
> git add .
> git commit -m 'Tên những thay đổi hoặc cập nhật.'

Chú ý viết phần [Tên thay đổi hoặc cập nhật] rõ ràng và chi tiết.
![image](https://user-images.githubusercontent.com/67773933/115964244-b6a0fa00-a54d-11eb-8852-c526bf111946.png)

#Bước 8: Đưa code từ local lên remote
> git push origin [Tên branch đang thao tác]

hoặc (nếu lệnh trên báo lỗi)
> git --set-upstream ogrin [Tên branch đang thao tác]

![image](https://user-images.githubusercontent.com/67773933/115964299-ff58b300-a54d-11eb-8901-afe6b8d72c47.png)

#Bước 9: Lên Github tạo pull request

#Bước 10: Kiểm tra branch đã lên remote chưa
> git branch -a

#Bước 11: Khi chuẩn bị code tiếp -> báo cho DT trước khi update code
> git fetch --prune

Kiểm tra lại các branch
> git branch -a

Khi thấy branch feature/task_đã_làm bị xoá -> code đã được accept và merge với nhánh Develop.

#Bước 12: Checkout nhánh Develop, pull code mới nhất và lặp lại
> git checkout develop
> git pull
