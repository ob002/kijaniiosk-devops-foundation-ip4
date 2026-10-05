# Data source to dynamically fetch IP from Multipass
data "external" "multipass_ip" {
  program = ["bash", "${path.module}/get_ip.sh"]
  
  query = {
    name = var.server_name
  }
}

resource "null_resource" "app_server" {
  triggers = {
    server_name   = var.server_name
    server_role   = var.server_role
    instance_type = var.instance_type
    key_name      = var.key_name
    # Depend on the data source to ensure IP is fetched
    server_ip     = data.external.multipass_ip.result.ip
  }
}
