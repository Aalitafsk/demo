
module "demo-subnet" {
    source = "./modules/subnet/"
    demo-vpc-cidr = var.vpc-cidr
    env = var.environment
    demo-subnet-cidr = var.subnet-cidr
    availability_zone = var.availability_zone
    # availability_zone
}




    resource "aws_route_table_association" "demo-association-to-subnet" {
        # to make a subnet as the public subnet
        # provider = aws1.silver
        subnet_id = module.demo-subnet.subnet-id.id
        route_table_id = module.demo-subnet.routtableid.id
    }

    resource "aws_security_group" "demo-SG-1" {
        # provider = aws1.silver
        name = "my-demo-sg"
        vpc_id = module.demo-subnet.vpcid.id

        # for inbound/incoming traffic 
        ingress  {
            from_port = 22
            to_port = 22
            # to add the range of the port as from_port = 22 to_port = 30000 . means it allow the ports range from the 22 to 30000.
            protocol = "tcp"
            # source = means which cidr block range is allowed here 
            cidr_blocks = [var.my-ip]
        }

        ingress {
            from_port = 8080
            to_port = 8080
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }

        # for outbound/outgoing traffic 
        # to install or download the softwares, binaries, fetch from the internet 
        # to install linux packages 
        # like to install docker container and fetch the images from the docker-hub
        # means request is going to the outside your server to the internet   
        
        egress {
            from_port = 0 # means any port not only the 0
            to_port = 0 # means any port not only the 0
            protocol = "-1" # means any protocol 
            cidr_blocks = ["0.0.0.0/0"]
            prefix_list_ids = [] # this is just allowing vpc endpoints 
        }

        tags = {
            Name = "${var.environment}-demo-SG-1"
        }
    }

    # fetch the ami dynamically 
    # but this are not mostly used since in organization their is the golden image 
    # we use this with the variables and then pass image id in the terraform.tfvars file 
    data "aws_ami" "AMI2-latest" {
        # provider = aws1.silver
        most_recent = true
        owners = ["amazon"]
        filter {
            name = "name"
            values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240719.0-x86_64-gp2"]
        }
    }
    /*
        filter {
            name = "virtualization-type"
            values = ["hvm"]
        }
    }
    */
    

    resource "aws_key_pair" "demo-key-pair" {
        # provider = aws1.silver
        key_name = "demo-key"
        public_key = file(var.public_key_location)
    }

    resource "aws_instance" "demo-ec2-1" {
        # provider = aws1.silver
        # ami = ami-03972092c42e8c0ca
        # ami is the OS image. this id is changes as per the region 
        ami = data.aws_ami.AMI2-latest.id
        instance_type = var.instance-type
        # this ami_id and instance_type both are required once. and all other are optional 
        # if we not define here then this instance launch in the default vpc one and also AZ

        subnet_id = module.demo-subnet.subnet-id.id
        # this is actual list string as ids 's' comes here
        vpc_security_group_ids = [aws_security_group.demo-SG-1.id]
        availability_zone = var.availability_zone

        associate_public_ip_address = true
        # create the key-pair using the aws console
        # this keys are the region level not the vpc  level  
        key_name = aws_key_pair.demo-key-pair.key_name
# all this is run by ec2-user
        user_data = <<EOF
                         #!/bin/bash
                         sudo yum update -y && sudo yum install -y docker 
                         sudo systemctl start docker
                         sudo usermod -aG docker ec2-user
                         docker run -p 8080:80 nginx
        EOF
# on chrome  public-ip:8080
# we can run the file as follows
#        user_data = file("shell-script.sh")
# place this file shell-script.sh in same floder along with this file only 

        tags = {
            Name = "${var.environment}-demo-ec2"
        }
    }

    

