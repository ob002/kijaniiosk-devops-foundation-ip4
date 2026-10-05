terraform {
  required_version = ">= 1.0"
}

# Call the reusable module using for_each
module "servers" {
  source = "./modules/app_server"

  for_each = var.server_definitions

  server_name   = each.value.name
  server_role   = each.value.role
  instance_type = var.instance_type
  key_name      = var.key_name
}