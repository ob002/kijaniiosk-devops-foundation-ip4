variable "region" {
  description = "Cloud region for resource deployment"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type for app servers"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name for server access"
  type        = string
  default     = "kijaniiosk-key"
}

variable "server_definitions" {
  description = "Map of server names to their configurations"
  type = map(object({
    name = string
    role = string
  }))
  default = {
    api      = { name = "kijaniiosk-api", role = "api" }
    payments = { name = "kijaniiosk-payments", role = "payments" }
    logs     = { name = "kijaniiosk-logs", role = "logs" }
  }
}