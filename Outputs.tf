
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR range of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "environment" {
  description = "Selected deployment environment"
  value       = var.environment
}

