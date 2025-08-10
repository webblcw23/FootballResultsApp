variable "name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "storage_account_name" { type = string }
variable "tags" { type = map(string) }

variable "sports_api_base" {
  type    = string
  default = ""
}
variable "results_path" {
  type    = string
  default = ""
}
variable "fixtures_path" {
  type    = string
  default = ""
}
variable "team_id" {
  type    = string
  default = "rangers"
}

variable "allowed_origins" {
  type    = list(string)
  default = ["*"] # For demo. Lock to your static site origin later.
}
