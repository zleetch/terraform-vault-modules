variable "secret_engine" {
  description = "Secret Engine"
  type        = any
}

variable "policies" {
  description = "All Policies"
  type        = list(string)
}
