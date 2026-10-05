variable "server_name" {
  description = "Name of the server instance"
  type        = string
}

variable "server_role" {
  description = "Role of the server (api, payments, logs)"
  type        = string
}

variable "instance_type" {
  description = "Instance type (e.g., t3.micro or Multipass spec)"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}