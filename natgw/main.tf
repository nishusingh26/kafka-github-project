resource "aws_eip" "kafka-nat" {
    domain = var.eip_domain
}

resource "aws_nat_gateway" "kafka-nat-gw" {
  allocation_id = aws_eip.kafka-nat.id
  subnet_id     = "subnet-0b3649cc8734b995d"

  tags = {
    Name = var.nat_tag
  }
}
