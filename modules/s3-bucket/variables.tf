variable "block_public_acls" {
  description = " Whether Amazon S3 should block public ACLs for this bucket. Default: true."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket. Default: true"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket. Default: true"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket. Default: true"
  type        = bool
  default     = true
}

variable "enable_versioning" {
  description = "The versioning state of the bucket. Default: Disabled."
  type        = string
  default     = "Disabled"
}

variable "full_access_principals" {
  description = "The FULL ACCESS principal list. Default is empty."
  type        = list(string)
  default     = []
}

variable "custom_policy_statements" {
  description = "The customized policy list. Default is empty."
  default     = []
}

variable "bucket_name" {
  description = "The S3 bucket name. Please follow the standard naming convention."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-.]{3,63}$", var.bucket_name)) && length(var.bucket_name) <= 63
    error_message = "The bucket name must be between 3 and 63 characters long. It must contain only lowercase letters, numbers, hyphens, and dots. It cannot end with a hyphen or dot, and cannot have a dot adjacent to a hyphen."
  }

}