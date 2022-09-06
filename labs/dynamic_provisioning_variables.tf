# updated variables.tf
variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "ExampleNginxContainer"
}

variable "internal_port" {
  description = "Internal port of the container"
  type        = number
  default     = 80
}

variable "external_port" {
  description = "External port on the container"
  type        = number
  default     = 2224
}
