output "api_server_ip" {
  description = "IP address of the API server"
  value       = module.servers["api"].server_ip
}

output "payments_server_ip" {
  description = "IP address of the Payments server"
  value       = module.servers["payments"].server_ip
}

output "logs_server_ip" {
  description = "IP address of the Logs server"
  value       = module.servers["logs"].server_ip
}

output "ssh_commands" {
  description = "SSH commands for all servers"
  value = {
    api      = module.servers["api"].ssh_command
    payments = module.servers["payments"].ssh_command
    logs     = module.servers["logs"].ssh_command
  }
}