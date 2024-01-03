# create a VPC
resource "aws_vpc" "vpc_1" {
  cidr_block       = var.vpc_cidr_range
  instance_tenancy = var.instance_tenancy_type

  tags = {
    Name = "${var.vpc_name}"
  }
}

