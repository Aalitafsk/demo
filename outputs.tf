
output "ec2-public-ip" {
    value = module.webserver.ec2-public-ip
}

output "ec2-private-ip" {
    value = module.webserver.ec2-private-ip
}

output "ami-id" {
    value = module.webserver.ami-id
}