output "id" {
  description = "The id of the VPC."
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "The CDIR block used for the VPC."
  value       = aws_vpc.vpc.cidr_block
}

output "vpc_arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.vpc.arn
}