/* Show an example of loops using the count parameter by
   creating multiple IAM users */

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 4.0"
    }
  }
}
    
/* Configure our AWS configuration */
provider "aws" {
  region = "us-east-2"
}

/* Create multiple IAM users using count */
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]   // count creates the return value "count.index"
}
