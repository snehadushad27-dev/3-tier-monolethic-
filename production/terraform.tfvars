rg = {
  rg1 = {
    name     = "producation"
    location = "central india"
  }

  rg2 = {
    name     = "development"
    location = "westus"
  }
}

vnets = {
  vnet1 = {
    name                = "prod-vnet"
    resource_group_name = "producation"
    location            = "central india"
    address_space       = ["10.0.0.0/16"]
  }

  vnet2 = {
    name                = "dev-vnet"
    resource_group_name = "development"
    location            = "westus"
    address_space       = ["10.1.0.0/16"]
  }
}

subs = {
  sub1 = {
    name                 = "front-end"
    resource_group_name  = "producation"
    virtual_network_name = "prod-vnet"
    address_prefixes     = ["10.0.1.0/26"]
  }

  sub2 = {
    name                 = "back-end"
    resource_group_name  = "development"
    virtual_network_name = "dev-vnet"
    address_prefixes     = ["10.1.1.0/26"]
  }

}

pips = {
  pip1 = {
    name                = "pip-prod"
    resource_group_name = "producation"
    location            = "central india"
  }
  pip2 = {
    name                = "pip-dev"
    resource_group_name = "development"
    location            = "westus"
  }
}

nsgs = {
  nsg1 = {
    name                 = "nsg-prod"
    resource_group_name  = "producation"
    location             = "central india"
    virtual_network_name = "prod-vnet"
    subnet_name          = "front-end"
  }

  nsg2 = {
    name                 = "nsg-dev"
    resource_group_name  = "development"
    location             = "westus"
    virtual_network_name = "dev-vnet"
    subnet_name          = "back-end"
  }
}

nics = {
  nic1 = {
    name                 = "nic-prod"
    resource_group_name  = "producation"
    location             = "central india"
    subnet_name          = "front-end"
    virtual_network_name = "prod-vnet"
    public_ip_name       = "pip-prod"
  }
  nic2 = {
    name                 = "nic-dev"
    resource_group_name  = "development"
    location             = "westus"
    virtual_network_name = "dev-vnet"
    subnet_name          = "back-end"
    public_ip_name       = "pip-dev"
  }
}

vms = {
  vm1 = {
    name                = "linux-vm"
    resource_group_name = "producation"
    location            = "central india"
    vm_size             = "Standard_D2s_v3"
    computer_name       = "my-linux"
    admin_username      = "azurermuser"
    admin_password      = "Asdf@123"
    publisher           = "Canonical"
    offer               = "ubuntu-24_04-lts"
    sku                 = "server"
    nic_name            = "nic-prod"
    os_type             = "linux"
  }
  vm2 = {
    name                = "window-vm"
    resource_group_name = "development"
    location            = "westus"
    vm_size             = "Standard_D2s_v3"
    computer_name       = "my-window"
    admin_username      = "azurermuser"
    admin_password      = "Asdf@123"
    publisher           = "MicrosoftWindowsServer"
    offer               = "WindowsServer"
    sku                 = "2016-Datacenter"
    nic_name            = "nic-dev"
    os_type             = "window"
  }
}
