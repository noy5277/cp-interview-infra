variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
}

variable "eks_version" {
  description = "The version of the EKS cluster"
  type = string
}

variable "label" {
  description = "A label to identify the node group"
  type = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type = map(string)
}

variable "subnets_ids" {
  description = "Private subnets for your worker nodes"
  type        = list(string)
  validation {
    condition     = length(var.subnets_ids) > 0
    error_message = "ERROR: You must specify at least one subnet."
  }
}

variable "instance_types" {
  description = "The instance types for the EKS node group (e.g., [\"t3.large\", \"t3a.large\"]). If not specified, it will default to a single instance type based on the nodes_instance_type variable."
  type        = list(string)
}

variable "capacity_type" {
  description = "The capacity type for the EKS node group (e.g., ON_DEMAND, SPOT)"
  type        = string
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], upper(var.capacity_type))
    error_message = "ERROR: capacity_type must be either ON_DEMAND or SPOT."
  }
}

variable "min_nodes" {
  description = "Minimum number of Kubernets nodes"
  default     = 2
  type        = number
  validation {
    condition     = var.min_nodes > 1
    error_message = "ERROR: Minimum number of nodes must be greater than 1 for HA Purposes."
  }
}

variable "max_nodes" {
  description = "Maximum number of Kubernets nodes"
  default     = "3"
  type        = string
}

variable "desired_nodes" {
  description = "Desired number of Kubernets nodes"
  default     = "2"
  type        = string
}