
data "aws_availability_zones" "available" {}

resource "aws_subnet" "Private_Subnet" {
  count = length(var.private-subnet)
  //az_count = "${length(data.aws_availability_zones.available.names)}"

  vpc_id     = "vpc-02a5b0fe61d157137"
  cidr_block = var.private-subnet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    count= length(var.private-subnet-tag)
    Name = var.private-subnet-tag[count.index]
  }
}