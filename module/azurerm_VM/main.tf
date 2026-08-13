resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = var.vms
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = "Standard_D2s_v3"

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  disable_password_authentication = "false"

  network_interface_ids = [
    data.azurerm_network_interface.nicd[each.key].id
  ]




  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}



data "azurerm_network_interface" "nicd" {
  for_each            = var.vms
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name

}