output "container_id" {
  value = docker_container.my_app.id
}
output "container_ports" {
  value = docker_container.my_app.ports
}
