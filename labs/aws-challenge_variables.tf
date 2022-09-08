/* Challenge Solution - Terrform and AWS 
   Create this file to track the variables used
   variables.tf */

# default value of instance_type should be t2.micro
variable "instance_type" {
  description = "size of the AWS instance"
  type        = string
  default     = "t2.micro"
}

# default value of name should be AltaResearch
variable "name" {
  description = "name of the ec2 instance"
  type        = string
  default     = "AltaResearch"
}

# default value of region should be us-west-2
variable "region" {
  description = "region to launch in"
  # FYI regions are tightly tied to the ami
  # do not change a region without also changing the ami
  type        = string
  default     = "us-west-2"
}

# default value of ami should be ami-830c94e3 
variable "ami" {
  description = "amazon machine imagine (ami) value to use"
  # FYI regions are tightly tied to the ami
  # do not change a region without also changing the ami
  type        = string
  default     = "ami-830c94e3"
}
