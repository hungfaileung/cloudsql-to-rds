variable "username" {
  description = "Username for the master DB user"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  sensitive   = true
}