# create VPC
resource "aws_vpc" "Demo_VPC" {
  cidr_block       = var.vpcCIDRblock
  instance_tenancy = "default"
}

# create the Public Subnet
resource "aws_subnet" "Public_Subnet" {
  vpc_id                  = aws_vpc.Demo_VPC.id
  cidr_block              = var.publicsubnetCIDRblock
  map_public_ip_on_launch = true
  availability_zone       = var.availabilityZone

} # end resource

# create the Private Subnet
resource "aws_subnet" "Private_Subnet" {
  vpc_id                  = aws_vpc.Demo_VPC.id
  cidr_block              = var.privatesubnetCIDRblock
  map_public_ip_on_launch = true
  availability_zone       = var.availabilityZone1

} # end resource

# Define the internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = "${aws_vpc.Demo_VPC.id}"

  
}

# Define the route table for public subnet
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.Demo_VPC.id}"

  #edir route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IGW.id}"
  }

  
}

# Define the route table for private subnet
resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.Demo_VPC.id}"


 
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id = "${aws_subnet.Public_Subnet.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

# Assign the route table to the private Subnet
resource "aws_route_table_association" "private-rt" {
  subnet_id = "${aws_subnet.Private_Subnet.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

# Define the security group for public subnet
resource "aws_security_group" "sgweb" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.Demo_VPC.id}"

 
}

  



