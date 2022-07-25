variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "uksouth" 
}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account. Debe ser único"
  default = "stcp2diagnosticsalmarco"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública para validar el usuario en las máquinas desplegadas"
  default = "~/.ssh/id_rsa.pub" 
}

variable "ssh_user" {
  type = string
  description = "Usuario para operar en las máquinas"
  default = "centos"
}

variable "location_name" {
  type = string
  description = "Región de Azure seleccionada"
  default = "uksouth"
}

variable "project_name" {
  type = string
  description = "Nombre del projecto para los tags"
  default = "cp2"
}

variable "address_space" {
  type = string
  description = "CIDR para la Vnet"
  default = "10.0.0.0/16"
}

variable "address_prefixe" {
  type = string
  description = "CIDR para la subnet"
  default = "10.0.1.0/24"
}

variable "master_vm_size" {
  type = string
  description = "Tamaño, cpu, disco para master"
  default = "Standard_F2s_v2"
}

variable "master_internal_ip" {
  type = string
  description = "ip privada, dentro del espacio la direcciónes del la subnet"
  default = "10.0.1.10"
}

variable "worker_vm_size" {
  type = string
  description = "Tamaño, cpu, disco para el worker"
  default = "Standard_F2s_v2"
}

variable "workwer_internal_ip" {
  type = string
  description = "ip privada, dentro del espacio la direcciónes del la subnet"
  default = "10.0.1.20"
}

variable "nfs_vm_size" {
  type = string
  description = "Tamaño, cpu, disco para nfs"
  default = "Standard_Ds2_v2"
}

variable "nfs_internal_ip" {
  type = string
  description = "ip privada, dentro del espacio la direcciónes del la subnet"
  default = "10.0.1.30"
}