
variable "natgw_id" {
  type = string
  description = "This is IGW ID"
}

variable "Private_Route_Tag" {
  default = "kafka-private-route"
  description = "Private Route Table"
}

variable "private_subnet_first_id" {
  description = "This is Private first subnet"
}

variable "private_subnet_second_id" {
  description = "This is Private second subnet"
}

variable "private_route_id" {
  description = "This is Private route subnet"
}
