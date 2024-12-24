variable "name" {
  type = string
}

variable "cluster" {
  type = list(object({
    cluster_id = string
    zone       = optional(string)
    num_nodes  = optional(number)
    autoscaling_config = optional(object({
      min_nodes      = number
      max_nodes      = number
      cpu_target     = number
      storage_target = number
    }))
    storage_type = optional(string)
    kms_key_name = optional(string)
  }))
}

variable "project" {
  type    = string
  default = null
}

variable "display_name" {
  type    = string
  default = null
}

variable "force_destroy" {
  type    = bool
  default = null
}

variable "deletion_protection" {
  type    = bool
  default = null
}

variable "labels" {
  type    = map(string)
  default = null
}

variable "members" {
  type    = list(string)
  default = []
}