variable "s3-backend-name" {
  description = "s3 bucket for terraform backend"
  type        = string
}

variable "env" {
  description = "eks environments. examples: dev,stage,prod"
}

variable "eks_name" {
  description = "The eks cluster name"
  type        = string
}

variable "aws_region" {
  description = "region to create resources"
  type        = string
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "cidr block"
  type        = string
}

variable "enable_dns_support" {
  description = "vpc dns support"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "vpc dns hostnames"
  type        = bool
}

variable "subnets" {
  type = map(object({
    cidr_block        = string,
    availability_zone = string,
    type              = string
  }))
  description = "Eks subnetes"
}

variable "kubernetes_resources_ip_cidr" {
  description = "The CIDR block to assign Kubernetes pod and service IP addresses from"
  type        = string
  default     = "172.16.0.0/16"
}

variable "node_groups" {
  description = "A list of maps, where each map represents a node group with its configuration. Each map should contain the following keys: name (string), instance_types (list of strings), capacity_type (string, either 'ON_DEMAND' or 'SPOT'), min_nodes (number), max_nodes (number), desired_nodes (number), and node_group_label (string)."
  type = map(object({
    instance_types     = list(string)
    security_group_ids = list(string)
    subnets_ids        = list(string)
    capacity_type      = string
    min_nodes          = number
    max_nodes          = number
    desired_nodes      = number
    label              = string
  }))
  default = {}
}

variable "eks_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A map of additional custom tags to use for the eks cluster resources"
}

variable "endpoint_private_access" {
  description = "Enable private access endpoint to cluster"
  type        = string
}

variable "endpoint_public_access" {
  description = "Enable public access endpoint to cluster"
  type        = string
}

variable "addons" {
  type        = list(string)
  description = "Eks addons names"
  default     = []
}
