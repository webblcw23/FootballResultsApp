variable "client_id" {}
variable "client_secret" {
  sensitive = true
}
variable "tenant_id" {}
variable "subscription_id" {}
variable "admin_password" {
  type = string
  sensitive = true  # Very important: Mark as sensitive
  description = "Admin password for the virtual machine" # Optional description
}



#create resource group in azure
