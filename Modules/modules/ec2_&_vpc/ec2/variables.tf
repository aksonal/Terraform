# variables for Ec2 instance creation
variable "ec2_ami" {
     description = "ami id to be used to create the ec2 instance"
}

variable "instance_type" {
     description = "Instance type"
}

variable "subnet_id" {
     description = "subent id in which ec2 is to be created"
}

variable "ec2_count" {
  description = "no of ec2 instances to be created"
}


