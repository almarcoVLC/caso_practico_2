# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.10.0"
    }
  }

  required_version = ">= 1.1.0"
}

#Configuramos como provider Azure. En ejecución se espera un azure CLI correctamente logueado
provider "azurerm" {
  features {}
}

locals {
  #Preparamos el tag, para mantener ordenados los componentes
  common_tags = {
    project = "${var.project_name}" 
  }
}

#Resource group, se crea el primero porque todos los compentes estarán contenidos en él
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}-${var.location}"
  location = var.location

  tags = "${local.common_tags}"
}

#El storage se usará en todas las VMs, se crea con antelación
resource "azurerm_storage_account" "diagnostics" {
  name                     = var.storage_account
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.rg
  ]

  tags = "${local.common_tags}"
}