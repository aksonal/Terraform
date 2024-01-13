#Global variable
variable "aws_region" {
  description = "region in which the resources to be deployed"
  default = "us-east-1"
}

# EC2 variables
variable "ec2_ami" {
  description = "ami to use to create instance"
}

variable "ec2_instance_type" {
  description = "instance type to use to create instance"
  default = "t2.micro"
}

variable "instance_name" {
  description = "name of the instance"
}



