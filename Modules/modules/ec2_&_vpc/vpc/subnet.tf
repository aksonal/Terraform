# create subnet
resource "aws_subnet" "subnet_1" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_range

  tags = {
    Name = "${var.subnet_name}"
  }
}