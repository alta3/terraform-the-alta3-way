/* Challenge Solution - Terrform and AWS 
   main.tf */

terraform {
  required_providers {
    aws = {
      # short for registry.terraform.io/hashicorp/aws
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}


/* Provider Block
   declare the specified provider and other settings */

provider "aws" {
  profile = "default"
  region  = var.region
}


/* Resource Block
   The resources to build (EC2, S3 bucket, etc.)       
resource <resource type> <resource name>  */

resource "aws_instance" "app_server" {
  # ami points to an ubuntu image (these are unique per region)
  ami           = var.ami
  # size of the machine is t2.micro
  instance_type = var.instance_type
  # tag is metadata information
  tags = {
    Name = var.name
  }
}
