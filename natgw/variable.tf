variable "eip_domain" {
  type = string
  description = "This is the Kafka Nat Gateway Creation"
}

variable "subnet_idd" {
  type = string
  description = "This is the Kafka Nat Gateway Creation"
}

variable "nat_tag" {
  type = string
  description = "This is the Kafka Nat Gateway Creation"
  default = "kafka-nat-01"
}