resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  
  tags = {
    Name = var.instance_name
  }
}