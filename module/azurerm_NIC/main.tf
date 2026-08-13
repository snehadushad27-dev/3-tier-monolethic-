resource "azurerm_network_interface" "nic" {
    for_each = var.nics 
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location

    ip_configuration {
        name = each.value.name
      subnet_id = data.azurerm_subnet.subd[each.key].id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id =data.azurerm_public_ip.pipd[each.key].id
    }
  
}
 data "azurerm_subnet" "subd" {
        for_each = var.nics
        name = each.value.subnet_name
        resource_group_name = each.value.resource_group_name
        virtual_network_name = each.value.virtual_network_name
    }

    data "azurerm_public_ip" "pipd" {
        for_each = var.nics
        name = each.value.public_ip_name
        resource_group_name = each.value.resource_group_name
      
    }