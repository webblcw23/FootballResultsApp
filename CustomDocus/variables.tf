variable "admin_username" {
  description = "The administrator username for the virtual machine."
}

variable "admin_password" {
  description = "The admin password for the VM"
  sensitive   = true
}
