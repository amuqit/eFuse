variable "aws_region" {
  description = "The AWS region to use to create resources."
  default     = "us-west-2"
}

variable "bucket_prefix" {
    type        = string
    description = "Creates a unique bucket name beginning with the specified prefix."
    default     = "efusebucket-"
}

variable "tags" {
    type        = map
    description = "A mapping of tags to assign to the bucket."
    default     = {
        environment = "DEV"
        terraform   = "true"
    }
}

variable "versioning" {
    type        = bool
    description = "A state of versioning."
    default     = true
}

// Update to make bucket public: 
variable "acl" {
    type        = string
    description = " Defaults to private "
    default     = "public"
}