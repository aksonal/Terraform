provider "aws" {
    region = "us-east-1"
}

#security group

resource "aws_security_group" "allow_tls" {
  name        = "sonal-sg-test"
  description = "Allow TLS inbound traffic and all outbound traffic"
}

variable "sg_ingress" {
  type = map(list(string))
  description = "SG inbound rules"
  default = {
    80 = ["10.0.0.0/16","10.0.1.0/24"]
    443 = ["172.0.2.0/24"]
  }
}

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

variable "sg_egress" {
  type = map(list(string))
  description = "SG outbound rules"
  default = {
    88 = ["10.0.0.0/16","10.0.1.0/24"]
    444 = ["172.0.2.0/24"]
  }
}

#egress rule
resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.allow_tls.id

  for_each = {
    for item in flatten([
      for port,dest in var.sg_egress : [
              for dst in dest:[
               {
                key = "${port}-${dst}"
                port = port 
                cidr = dst 
               }
              ]
             ]
             ]) : item.key => item
    }

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.port
  ip_protocol = "tcp"
  to_port     = each.value.port
}
