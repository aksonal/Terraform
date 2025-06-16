provider "aws" {
    region = "us-east-1"
    #profile = "vau-dev-test"
}

variable "sg_names_n_ingress" {
  description = "names of the SG's and ingress ports n cidr"
  type = map(map(list(string)))
  default = {
    sg_1 = {
      80  = ["10.0.0.0/16"]
      443 = ["10.0.1.0/24"]
    },
    sg_2 = {
      5432 = ["172.0.0.0/16"]
    }
  }  
}

#security group
resource "aws_security_group" "allow_tls" {
  for_each = var.sg_names_n_ingress
  name        = each.key
  description = "Allow TLS inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound" {
  security_group_id = aws_security_group.allow_tls[each.value.sg_name].id

  for_each = { 
              for item in local.Security-groups:
              item.key => item 
             } 

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.port
  to_port     = each.value.port
  ip_protocol = "tcp"
}

