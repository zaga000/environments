output "vpc_id" {
  description = "The ID of the main VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_cidr_block" {
  description = "CIDR blocks of public subnets"
  value       = aws_subnet.public_subnet[*].cidr_block
}

output "private_subnet_cidr_block" {
  description = "CIDR blocks of private subnets"
  value       = aws_subnet.private_subnet[*].cidr_block
}

output "db_subnet_cidr_block" {
  description = "CIDR blocks of database subnets"
  value       = aws_subnet.db_subnet[*].cidr_block
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private_subnet[*].id
}

output "db_subnet_ids" {
  description = "IDs of database subnets"
  value       = aws_subnet.db_subnet[*].id
}