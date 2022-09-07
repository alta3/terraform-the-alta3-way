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
  for_each = toset(var.user_names)  // important to transform the list of strings into a set
  name = each.value   // for_each creates the return value "each.value"
    
  // we can REMOVE the following lines      
  // count = length(var.user_names)      
  // name  = var.user_names[count.index]   // count creates the return value "count.index"
}
