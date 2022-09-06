/* main.tf
   Alta3 Research - rzfeeser@alta3.com
   Updated to include an error condition */

# interact with docker
provider "docker" {}

# create random_ resources
provider "random" {}

# interact with time data
provider "time" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

# available from random.random_pet
resource "random_pet" "nginx" {
  length = 2
}

resource "docker_container" "nginx" {
  count = 4
  image = docker_image.nginx.latest
  name  = "nginx-${random_pet.nginx.id}-${count.index}"
  # name = "nginx-hoppy-frog-0"

  ports {
    internal = 80
    # 8000, 8001, 8002, 8003
    external = 8000 + count.index
  }
}

resource "docker_image" "redis" {
  name         = "redis:latest"
  keep_locally = true
}

resource "time_sleep" "wait_120_seconds" {
  depends_on = [docker_image.redis]

  create_duration = "120s"
}

resource "docker_container" "data" {
  # wait 120 seconds after downloading the image and launching the container
  depends_on = [time_sleep.wait_120_seconds]
  image      = docker_image.redis.latest
  name       = "data"

  ports {
    internal = 6379
    external = 6379
  }
}
