
output "ec2-public-ip" {
    value = aws_instance.demo-ec2-1.public_ip
}

output "ec2-private-ip" {
    value = aws_instance.demo-ec2-1.private_ip
}

output "ami-id" {
    value = data.aws_ami.AMI2-latest.id  
}