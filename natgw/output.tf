output "natgw_out" {
  description = "This is Kafka NAT Gateway Output"
  value = aws_nat_gateway.kafka-nat-gw.id
}