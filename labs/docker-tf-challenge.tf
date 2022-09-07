/* main.tf
   Alta3 Research - rzfeeser@alta3.com
   CHALLNEGE 01 - terraform configuration file to deploy an nginx container */

# terraform block
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

# provider block
provider "docker" {}

# resource block - ensures an image will become present
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true    // keep image after "destroy"
}

# resource block - ensures a container will become present
resource "docker_container" "nginx" {
  # reference to the "docker_image.nginx" resource
  # the "latest" references the image created in the other resource block
  image = docker_image.nginx.latest
  name  = "tutorial"
  # container ports
  # - internal is the port the container is listening on
  # - external is the port the local system is listening on
  ports {
    internal = 80
    external = 2224
  }
}
