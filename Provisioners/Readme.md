Trying out terraform provisioner's Practical

We use provisioners to execute some actions at the time of creation/destruction of resources.
If terraform does not provide the concept of provisioners then we might have to excute shell script or ansible scripts to run some commands inside ec2 instance during creation through terraform.
Running complex scripts through user-data in EC2 is not advised.


They are of 2 types 
- remote exec
- local exec
- file provisioner


Task/Script : 
- Creating 4 resources :- 1 VPC, 1 subent, 1 RT, 1 IGW, 1 EC2, 1 SG
  - 1 VPC
  - 1 pub subent
  - RT with internet gateway associated
  - associate this RT with subent
  - EC2 instance ( to host webserver)
  - Security group
