variable "tags" {
  description = "subnet tags"
  type = map(any)
}

variable "availability_zone" {
  description = "subnt availability zone"
  type = string
}

variable "cidr_block" {
  description = "subnet block"
  type = string
}

variable "vpc_id" {
  description = "subnet vpc id"
  type = string
}

variable "map_public_ip_on_launch" {
  description = "map public ip"
  type = string
}