resource "azurerm_virtual_machine" "vm" {
  for_each            = var.vms
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  vm_size             = each.value.vm_size

  storage_os_disk {
    name              = each.value.name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = each.value.computer_name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }

  dynamic "os_profile_linux_config" {
    for_each = each.value.os_type == "linux" ? [1] : []

    content {
      disable_password_authentication = false
    }
    dynamic "os_profile_windows_config" {
      for_each = each.value.os_type == "windows" ? [1] : []

      content {
        provision_vm_agent = true
      }
    }


  }
  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = "latest"
  }
  network_interface_ids = [data.azurerm_network_interface.nicd[each.key].id]
}

data "azurerm_network_interface" "nicd" {
  for_each            = var.vms
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name

}