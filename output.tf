output "app_url" {
  value = "http://${azurerm_container_group.aci-app.fqdn}:3000"
}