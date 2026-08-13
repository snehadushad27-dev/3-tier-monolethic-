module "resource" {
  source = "../module/azurerm_resource_group"
  rg     = var.rg

}

module "virtual_network" {
  depends_on = [module.resource]
  source     = "../module/azurerm_virtual_network"
  vnets      = var.vnets
}

module "subnet" {
  depends_on = [module.resource, module.virtual_network]
  source     = "../module/azurerm_subnet"
  subs       = var.subs

}
module "public_ip" {
  depends_on = [module.resource]
  source     = "../module/azurerm_Public_ip"
  pips       = var.pips
}

module "security" {
  depends_on = [module.resource,module.subnet]
  source     = "../module/azurerm_NSG"
  nsgs       = var.nsgs

}
module "interface" {

  depends_on = [module.subnet]
  source     = "../module/azurerm_NIC"
  nics       = var.nics

}

module "vm" {
  depends_on = [module.interface]
  source     = "../module/azurerm_VM"
  vms        = var.vms

}

