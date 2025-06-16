provider "aws" {
    region = "us-east-1"
}

variable "sg_rules" {
  description = "Security group definitions"
  type = map(object({
    ingress = optional(map(list(string)))  # port => list of CIDRs
    egress  = optional(map(list(string)))  # port => list of CIDRs
  }))
  default = {
    sg_1 = {
      ingress = {
        80  = ["10.0.0.0/16"]
        443 = ["10.0.1.0/24"]
      }
    },
    sg_2 = {
      ingress = {
        5432 = ["172.16.0.0/12"]
        22   = ["192.168.1.0/24"]
      }
      egress = {
        443 = ["0.0.0.0/0"]
        123 = ["1.1.1.1/32"]
      }
    },
    sg_3 = {
    # Both ingress and egress missing
  }
  }
}

#security group
resource "aws_security_group" "allow_tls" {
  for_each = var.sg_rules
  name        = each.key
  description = "Allow TLS inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound" {
  security_group_id = aws_security_group.allow_tls[each.value.sg_name].id

  for_each = { 
              for item in local.ingress_rule:
              item.key => item 
             } 

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.port
  to_port     = each.value.port
  ip_protocol = "tcp"
}

#egress rule
resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.allow_tls[each.value.sg_name].id

  for_each = { 
              for item in local.egress_rule:
              item.key => item 
             } 

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.port
  ip_protocol = "tcp"
  to_port     = each.value.port
}
