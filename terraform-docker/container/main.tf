resource "random_string" "random" {
  count   = var.countIn
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "app_container" {
  count = var.countIn
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.internalPortIn
    external = var.externalPortIn[count.index]
  }
  dynamic "volumes" {
    for_each = var.volumesIn
    content {
      container_path = volumes.value["containerPathEach"]
      volume_name    = module.volume[count.index].volumeOutput[volumes.key]
    }
  }

  provisioner "local-exec" {
    command = "echo ${self.name} : ${self.ip_address}:${join("", [for x in self.ports[*]["external"] : x])} >> containers.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f containers.txt"
  }
}

module "volume" {
  source      = "./volume"
  count       = var.countIn
  volumeCount = length(var.volumesIn)
  volumeName  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}.volume"
}
