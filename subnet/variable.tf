variable "private-subnet" {
  type = list(string)
  description = "This will create Private Subnet"
  default = [ "10.0.2.0/24", "10.0.4.0/24" ]
}

variable "private-subnet-tag" {
  type = list(string)
  description = "This will create Private Subnet Tags"
  default = [ "kafka-private-subnet-01" ,"kafka-private-subnet-02"]
}
