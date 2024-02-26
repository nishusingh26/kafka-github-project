module "subnet" {
    source  = "./subnet" 
}

module "natgw" {
    source  = "./natgw"
    eip_domain = var.eip_domain_name
    subnet_idd = "subnet-0cad8cc4c8d555c41"
}

module "routetable" {
    source = "./routetables"
    natgw_id = module.natgw.natgw_out
    
    private_route_id = module.routetable.Private_route_out
    private_subnet_first_id = module.subnet.Private_subnet_out[0]
    private_subnet_second_id = module.subnet.Private_subnet_out[1]
}

module "instance" {
    source = "./instance"

    private_subnet_first_id = module.subnet.Private_subnet_out[0]
    private_subnet_second_id = module.subnet.Private_subnet_out[1]
}
