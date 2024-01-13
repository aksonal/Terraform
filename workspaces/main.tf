module "ec2_instance" {
   source = "./module/ec2"
   ec2_ami = var.ec2_ami_value #ami-079db87dc4c10ac91"
   ec2_instance_type = var.ec2_instance_type_value
   instance_name = var.instance_name_is
}