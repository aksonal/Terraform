# EC2 variables
variable "ec2_ami_value" {
  description = "ami to use to create instance"
}

variable "ec2_instance_type_value" {
  description = "instance type to use to create instance"
  default = "t2.micro"
}

variable "instance_name_is" {
  description = "name of the instance"
}