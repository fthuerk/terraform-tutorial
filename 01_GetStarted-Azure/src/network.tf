# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-terraform-tutorial"
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name
}