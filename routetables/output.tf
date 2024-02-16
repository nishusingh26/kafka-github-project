output "Private_route_out" {
  description = "Output of Private Route Table"
  value = aws_route_table.kafka-private-route.id
}
