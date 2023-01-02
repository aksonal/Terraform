# data "aws_ami" "linux_ami" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-kernel-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

# }

data "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name
}