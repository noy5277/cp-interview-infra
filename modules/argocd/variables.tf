variable "eks_cluster_name" {
  type        = string
}

variable "argocd_namespace" {
  type = string
}

variable "cluster_display_name" {
  type = string
}

variable "cluster_server" {
  type = string
}

variable "cluster_bearer_token" {
  type      = string
  sensitive = true
}

variable "cluster_ca_data_b64" {
  type = string
}

variable "tls_insecure" {
  type    = bool
  default = false
}
