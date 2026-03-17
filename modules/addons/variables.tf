variable "addons" {
  type = list(string)
  description = "Eks addons names"
}

variable "cluster_name" {
  type = string
  description = "Eks cluster name"
}