variable "secret_engine" {
  description = "Secret Engine"
  type        = any
}

variable "policies" {
  description = "All Policies"
  type        = any
  default     = null
}

variable "databases" {
  description = "All Databases"
  type        = any
  default     = null
}

variable "database_roles" {
  description = "All Database Roles"
  type        = any
  default     = null
}

variable "database_static_roles" {
  description = "All Static Database Roles"
  type        = any
  default     = null
}
