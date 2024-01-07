Trying out terraform provisioner's Practical

We use provisioners to execute some actions at the time of creation/destruction of resources.
If terraform does not provide the concept of provisioners then we might have to excute shell script or ansible scripts to run some commands inside ec2 instance during creation through terraform.
Running complex scripts through user-data in EC2 is not advised.
