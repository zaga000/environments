output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].cidr_block
}

output "db_subnet_ids" {
  value = aws_subnet.db_subnet[*].cidr_block
}