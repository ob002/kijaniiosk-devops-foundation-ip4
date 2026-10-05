output "server_ip" {
  description = "Dynamic IP address of the app server from Multipass"
  value       = data.external.multipass_ip.result.ip
}

output "ssh_command" {
  description = "SSH command to connect to the server"
  value       = "ssh -i ~/.ssh/id_rsa ubuntu@${data.external.multipass_ip.result.ip}"
}
