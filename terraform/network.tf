# Todos los tf se lanzarán después del main.
# Aquí vamos a crear la vnet y la subnet. Con los security group que
# usarán las nics de las VM

#vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project_name}-${var.location}"
  address_space       = ["${var.address_space}"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = "${local.common_tags}"

  depends_on = [
    azurerm_resource_group.rg
  ]
}

#Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${var.project_name}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.address_prefixe}"]

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet
  ]
}

#Network Security Group para todos las vm, ssh
resource "azurerm_network_security_group" "nsg_ssh" {
  name                = "nsg-${var.project_name}-ssh-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]

  tags = "${local.common_tags}"
}

#Network Security Group para nodos master, web + hapeoxy
resource "azurerm_network_security_group" "nsg_master" {
  name                = "nsg-${var.project_name}-master-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  #Master tiene más puertos abierto y por lo tanto más reglas
  security_rule {
    name                       = "web"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "haproxy"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["30000-32767"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]

  tags = "${local.common_tags}"
}

