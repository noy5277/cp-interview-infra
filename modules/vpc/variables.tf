variable "vpc_name" {
  description = "The vpc name"
  type = string
}

variable "cidr_block" {
  description = "cidr block for vpc"
  type = string
}

variable "enable_dns_support" {
  description = "vpc dns support"
  type = string
}

variable "enable_dns_hostnames" {
  description = "hostname dns support"
  type = string
}