/* variables.tf
   Define the variables within our configuration. */
   
variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "GoLangServer"
}

variable "image_name" {
  description = "image to use for the Docker container"
  type        = string
}
