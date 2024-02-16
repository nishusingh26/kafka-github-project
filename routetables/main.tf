
resource "aws_route_table" "kafka-private-route" {
  vpc_id = "vpc-02a5b0fe61d157137"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.natgw_id
  }

  tags = {
    Name = var.Private_Route_Tag
  }
}

#------------------Private Association ---------------------

resource "aws_route_table_association" "Private_association_1" {
  subnet_id      = var.private_subnet_first_id
  route_table_id = var.private_route_id
}

resource "aws_route_table_association" "Private_association_2" {
  subnet_id      = var.private_subnet_second_id
  route_table_id = var.private_route_id
}

resource "aws_route_table_association" "Private_association_3" {
  subnet_id      = var.private_subnet_third_id
  route_table_id = var.private_route_id
}