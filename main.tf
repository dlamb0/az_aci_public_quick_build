

resource "azurerm_container_group" "aci-app" {
  name                = "${var.app_base_name}-acg"
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_address_type     = "Public"
  dns_name_label      = var.app_base_name
  os_type             = "Linux"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aci_identity.id]
  }

  image_registry_credential {
    server                    = var.acr_login_server
    user_assigned_identity_id = azurerm_user_assigned_identity.aci_identity.id
  }

  container {
    name   = var.app_base_name
    image  = var.container_image
    cpu    = "0.5"
    memory = "1"

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  depends_on = [azurerm_role_assignment.aci_acr_pull]

  tags = local.common_tags
}

resource "azurerm_user_assigned_identity" "aci_identity" {
  name                = "${var.app_base_name}-identity"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = local.common_tags
}

resource "azurerm_role_assignment" "aci_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aci_identity.principal_id
}

# Common tags applied to all resources
locals {
  common_tags = {
    owner       = var.owner_email
    environment = var.environment
    managed_by  = "terraform"
  }
}
