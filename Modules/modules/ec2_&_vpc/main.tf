# Instance Creation by calling module

module "ec2_instance" {
   source = "./modules/ec2"
   ec2_count =  2
   ec2_ami = "ami-079db87dc4c10ac91"
   instance_type = "t2.micro"
   subnet_id = module.my_vpc.subnet_id_is
 
}

module "my_vpc" {
   source = "./modules/vpc"
   vpc_cidr_range = "192.168.0.0/16"
   instance_tenancy_type = "default"
   vpc_name = "Test_VPC"
   vpc_id = module.my_vpc.vpc_id
   subnet_cidr_range = "192.168.0.0/24" 
   subnet_name = "Test_VPC_Subnet_1"
}

# print instance ip of instance created
output "ec2_instance_ip" {
  value = module.ec2_instance.public_ip[*]
}

# print vpc id
output "vpc_id_created" {
  value = module.my_vpc.vpc_id
}

# print subnet id
output "subnet_id_created" {
  value = module.my_vpc.subnet_id_is
}


