
variable "private_subnet_first_id" {
  description = "This is Private Subnet"
}
variable "private_subnet_second_id" {
  description = "This is Private Subnet"
}

variable "private_server_kafka_1" {
  default = "Kafka-1"
  description = "This is the Private server in Private Subnet "
}

variable "private_server_zookeeper_1" {
  default = "Zookeeper-1"
  description = "This is the Private server in Private Subnet "
}

variable "private_server_kafka_2" {
  default = "Kafka-2"
  description = "This is the Private server in Private Subnet "
}

variable "private_server_zookeeper_2" {
  default = "Zookeeper-2"
  description = "This is the Private server in Private Subnet "
}

variable "ingress_rule" {
  type = map(object({
    port = number
    protocol = string
    cidr_block = list(string)

  }))
  default = {
    "80" = {
      port = 80
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
    "443" = {
      port = 443
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
      "22" = {
      port = 22
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
  }
}


variable "egress_rule" {
type = map(object({
  port = number
  protocol = string
  cidr_block = list(string)

}))
default = {
  "0" = {
    port = 0
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
  }
}
}
