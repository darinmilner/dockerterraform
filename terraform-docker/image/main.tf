resource "docker_image" "container_image" {
  //Docker hub image name for node red
  name = var.image_in
}
