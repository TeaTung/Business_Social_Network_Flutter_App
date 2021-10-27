# Business_Social_Network_Flutter_App
### Clean-Code convention
+ In this project we use Pascal and Camel naming convention for variable name and function name
+ Access Modifiers must be clearly
+ Describe everything easy to confuse, cross class function & variables, dependencies, helpers in comment clearly in English
+ Add comma ',' after every parameter

### Git rules
+ Must not push code to branch master/main, push and create pull request from branch feature to branch develop.
+ Commit and push code to github from 7 A.M to 11 P.M, pull request after this time will be checked in next day.
+ Fetch code before coding new feature.
+ Each feature create a brand new branch.
+ Must not merge code.
### Git & Working flow
#Step 1: Clone Project
> git clone https://github.com/TeaTung/Business_Social_Network_Flutter_App.git

if any error occur, try:

> git clone http://github.com/TeaTung/Business_Social_Network_Flutter_App.git

![image](https://user-images.githubusercontent.com/67773933/115963852-8193a800-a54b-11eb-9fbd-e3a0b9833212.png)

#Step 2: Check local Git branch & remote Git branch.

> git branch -a

![image](https://user-images.githubusercontent.com/67773933/115963974-4a71c680-a54c-11eb-8957-ba4da13af117.png)

#Step 3: Fetch code from remote to local before working.
> git fetch origin develop

![image](https://user-images.githubusercontent.com/67773933/115964006-8573fa00-a54c-11eb-9dde-a99b51e44da1.png)

#Step 4: Checkout to develop branch.
> git checkout develop

![image](https://user-images.githubusercontent.com/67773933/115964039-b2281180-a54c-11eb-8bda-a3512ae6bc67.png)

[IMPORTANT] From this, every push and create pull request event will be pushed only to branch develop, must not work with master/main branch (this branch will store lasted stable state of project).

#Step 5: Checkout from branch develop to branch feature to working with your feature.
[IMPORTANT] Every push and create pull request event will be pushed only to branch develop, must not work with master/main branch (this branch will store lasted stable state of project).
> git checkout -b feature/tasks_name

#Step 6: [IMPORTANT] When everything have done, check status, test every parts of project from beginning flow of application.
> git status

![image](https://user-images.githubusercontent.com/67773933/115964200-7b9ec680-a54d-11eb-9b8a-2b944f47e44f.png)

#Step 7: Affter testing, add all files have change and commit.
> git add .
> git commit -m 'What are added, changed, removed, name of feature'

NOTICE [What are added, changed, removed, name of feature] must written in English clearly and detail.
![image](https://user-images.githubusercontent.com/67773933/115964244-b6a0fa00-a54d-11eb-8852-c526bf111946.png)

#Step 8: Push from local to remote
> git push origin [Name of branch that you are working]

if you just clone project, try:

> git --set-upstream origin [Name of branch that you are working]

this command will set up a tracking relationship between local and remote repo

![image](https://user-images.githubusercontent.com/67773933/115964299-ff58b300-a54d-11eb-8901-afe6b8d72c47.png)

#Step 9: Access Github.com and create pull request

#Step 10: Check branch have pushed or not. If anything go wrong you can't not see your branch as remote branch
> git branch -a

#Step 11: Before want to begin new section, ask Duong Tung check everything before update code
> git fetch --prune

Check all branch again
> git branch -a

If you see branch feature/name_of_your_branch is deleted, your code is accepted and merged to Develop. If anything wrong with that code you will receive email with comments.

#Step 12:Checkout Develop, pull newest code and repeat the process
> git checkout develop
> git pull
