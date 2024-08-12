
module "demo-subnet" {
    source = "./modules/subnet/"
    demo-vpc-cidr = var.vpc-cidr
    env = var.environment
    demo-subnet-cidr = var.subnet-cidr
    availability_zone = var.availability_zone
    # availability_zone
}

module "webserver" {
    source = "./modules/web-server"
    vpc-id = module.demo-subnet.vpcid.id
    my-ip = var.my-ip
    environment = var.environment
    public_key_location = var.public_key_location
    instance-type = var.instance-type
    availability_zone = var.availability_zone
    subnet-id = module.demo-subnet.subnet-id.id
}

resource "aws_route_table_association" "demo-association-to-subnet" {
    # to make a subnet as the public subnet
    # provider = aws1.silver
    subnet_id = module.demo-subnet.subnet-id.id
    route_table_id = module.demo-subnet.routtableid.id
}



    

