# Deploy ec2 instance with apache2 using terraform

resource "aws_instance" "Demo" {
  ami = var.ami
  instance_type = var.Instance_type
  associate_public_ip_address = true
  subnet_id =aws_subnet.Public_Subnet.id
  vpc_security_group_ids = [aws_security_group.sgweb.id]
  key_name = var.KEY_PAIR
  availability_zone = var.availabilityZone
  user_data = "${file("install.sh")}"
}

