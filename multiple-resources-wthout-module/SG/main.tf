provider "aws" {
    region = "us-east-1"
}

#security group
resource "aws_security_group" "allow_tls" {
  name        = "sonal-sg-test"
  description = "Allow TLS inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id
}

variable "sg_ingress" {
  type = map(list(string))
  description = "SG inbound rules"
  default = {
    80 = ["10.0.0.0/16","10.0.1.0/24"]
    443 = ["172.0.2.0/24"]
  }
}

# inbound rule
resource "aws_vpc_security_group_ingress_rule" "allow_inbound" {
  security_group_id = aws_security_group.allow_tls.id

  for_each = {
    for pair in flatten([
      for port, cidrs in var.sg_ingress : [
        for cidr in cidrs : {
          key   = "${port}-${cidr}"
          port  = tonumber(port)
          cidr  = cidr
        }
      ]
  ]) : pair.key => pair
  }

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.port
  to_port     = each.value.port
  ip_protocol = "tcp"
}

# outbound rule
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
