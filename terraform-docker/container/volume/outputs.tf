output "volumeOutput" {
  value = docker_volume.container_volume[*].name
}
