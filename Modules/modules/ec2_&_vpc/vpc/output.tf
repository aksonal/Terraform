# vpc id as output
output "vpc_id" {
  description = "vpc id"
  value = aws_vpc.vpc_1.id
}

#subent_id as output 
output "subnet_id_is" {
  description = "subnet id"
  value = aws_subnet.subnet_1.id
}