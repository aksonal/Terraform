# Instance Creation
resource "aws_instance" "ec2_instance_micro" {
  count                   = var.ec2_count # used to create fixed nummber of instances with similar types
  ami                     = "${var.ec2_ami}"
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
}