/* Challenge Solution - Terrform and Docker
   Create this file to track the variables used
   variables.tf */

# default value of container_name should be AltaResearchWebService
variable "container_name" {
  description = "name of the container"
  type        = string
  default     = "AltaResearchWebService"
}

# default value of internal_port should be 9876
variable "internal_port" {
  description = "internal port to be used"
  type        = number
  default     = 9876
}

# default value of internal_port should be 5432
variable "external_port" {
  description = "external port to be used"
  type        = number
  default     = 5432
}
