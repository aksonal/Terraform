output "public_ip" {
    value = aws_instance.ec2_instance_micro[*].public_ip  
}

output "instance_id" {
    value = aws_instance.ec2_instance_micro[*].id  
}