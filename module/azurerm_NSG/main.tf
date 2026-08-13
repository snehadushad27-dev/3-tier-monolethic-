resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsgs
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
}

resource "azurerm_subnet_network_security_group_association" "nsgass" {
  for_each                  = var.nsgs
  subnet_id                 = data.azurerm_subnet.subd[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

data "azurerm_subnet" "subd" {
  for_each             = var.nsgs
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}