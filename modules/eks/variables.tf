variable "vpc_id" {
  description = "ID of the VPC used for SG and Cluster, created externally to this module"
  type        = string
  nullable    = false
}

variable "cluster_name" {
  description = "Full name of the cluster"
  type        = string
  nullable    = false
}

variable "cluster_subnets_ids" {
  description = "Private subnets for your worker nodes"
  type        = list(string)
  validation {
    condition     = length(var.cluster_subnets_ids) > 0
    error_message = "ERROR: You must specify at least one subnet."
  }
}

variable "kubernetes_resources_ip_cidr" {
  description = "The CIDR block to assign Kubernetes pod and service IP addresses from"
  type        = string
  default = "172.16.0.0/16"
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
  type = string
}

variable "endpoint_public_access" {
  description = "Enable public access endpoint to cluster"
  type = string
}
