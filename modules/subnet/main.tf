
    resource "aws_vpc" "demo-vpc-1" {
        #provider = aws1.silver
        cidr_block = var.demo-vpc-cidr
        tags = {
            Name = "${var.env}-demo-vpc-1"
        }  
    }

    resource "aws_subnet" "demo-subnet-1" {
        # provider = aws1.silver
        vpc_id = aws_vpc.demo-vpc-1.id
        cidr_block = var.demo-subnet-cidr
        availability_zone = var.availability_zone
        tags = {
            Name = "${var.env}-demo-subnet-1"
        }
    }

    resource "aws_internet_gateway" "demo-IGW-1" {
        # provider = aws1.silver
        vpc_id = aws_vpc.demo-vpc-1.id
        tags = {
            Name = "${var.env}-demo-IGW-1"
        }
    }

    resource "aws_route_table" "demo-route-table-1" {
        # provider = aws1.silver
        vpc_id = aws_vpc.demo-vpc-1.id
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.demo-IGW-1.id
        }
        tags = {
            Name = "${var.env}-demo-route-1"
        }
    }