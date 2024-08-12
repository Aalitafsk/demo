/*
variable "demo-vpc" {
    description = "cidr value for the vpc"
    type = list(string)
    default = ["10.1.0.0/16", "10.1.10.0/24"]
}
*/

variable "availability_zone" {
    description = "enter here AZ"
    type = string
    default = "us-east-1b"
}


/*
variable "env" {
    description = "enter here env name"
    type = string
    default = "uat"
}
*/
variable "my-ip" {
    description = "you may entere here particular ip"
    # type = string
    default = "0.0.0.0/0"
}

variable "instance-type" {
    description = "enter here instance type"
    type = string
    default = "t2.medium"
}

variable "public_key_location" {
    description = "run the ssh-keygen in linux and paste the addresses of public file"
    type = string
    default = "~/.ssh/id_rsa.pub"
}

variable "environment" {}
variable "vpc-cidr" {}
variable "subnet-cidr" {}
