#Definición de la nic, las ips y la propia VM para worker
#Los nombres aplican las convenciones de Azure

#Ip pública para el worker
resource "azurerm_public_ip" "worker_pip" {
  name                = "pip-${var.project_name}-worker-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"

  tags = "${local.common_tags}"
}

#nic especifica de esta VM
resource "azurerm_network_interface" "worker_nic" {
  name                = "nic-${var.project_name}-worker"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "${var.workwer_internal_ip}"
    public_ip_address_id          = azurerm_public_ip.worker_pip.id
  }

  tags = "${local.common_tags}"
}

# Asociamos el grupo de seguridad al nic
resource "azurerm_network_interface_security_group_association" "nsg_ssh_to_worker_nic" {
  network_interface_id      = azurerm_network_interface.worker_nic.id
  network_security_group_id = azurerm_network_security_group.nsg_ssh.id
}

resource "azurerm_linux_virtual_machine" "worker_vm" {
  #El nombre se genera con las recomendaciones de Aazure
  name                = "vm${var.project_name}worker"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = "${var.worker_vm_size}"
  
  admin_username      = "${var.ssh_user}"

  #Asociación de la nic
  network_interface_ids = [
    azurerm_network_interface.worker_nic.id
  ]

  #path de la clave pública, se usará para el login sin password
  admin_ssh_key {
    username   = "${var.ssh_user}"
    public_key = file("${var.public_key_path}")
  }

  #dico permanente
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  #imagen del Centos 8 del azure registry
  plan {
    name      = "centos-8-stream-free"
    product   = "centos-8-stream-free"
    publisher = "cognosys"
  }

  source_image_reference {
    publisher = "cognosys"
    offer     = "centos-8-stream-free"
    sku       = "centos-8-stream-free"
    version   = "22.03.28"
  }

  #Diagnosticos y logs
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.diagnostics.primary_blob_endpoint
  }

  tags = "${local.common_tags}"
}
