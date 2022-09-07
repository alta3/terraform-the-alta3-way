/* variables.tf
   dynamic provisioning of values within our solution for AWS */

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
