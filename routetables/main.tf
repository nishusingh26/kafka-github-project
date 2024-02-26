
resource "aws_route_table" "kafka-private-route" {
  vpc_id = "vpc-00e59ad4b212fe57b"

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
