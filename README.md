# caso_practico_2

# Contenido

```
├── ansible
│   ├── deploy.sh -> Script para lanzar los playbook con los timeout necesarios
│   ├── hosts -> Lista de host a actualizar con los outputs de Terraform. Y variables
│   ├── playbook-common.yml -> Playbook a ejecutar sobre todas las VM y configurar el nfs
│   ├── playbook-deploy.yml -> Playbook para desplegar la aplicación en Kubernetes con persistencia
│   ├── playbook-kubernetes.yml -> Playbook para configurar todos los host que serán nodos, más el master y los workers
│   ├── playbook-test.yml -> Playbook para compbar el estdo de nodos, pods y servicios
│   └── roles
│       ├── common
│       ├── deploy-ngnix
│       ├── deploy-pv-pvc
│       ├── kubernete-common
│       ├── kubernete-master
│       ├── kubernete-worker
│       ├── nfs
│       ├── test-nodes
│       ├── test-pods
│       ├── test-pv-pvc
│       └── test-services
├── entrega
│       └── capturas -> Camputuras para aañdir al documento de la entrega
└── terraform
    ├── correccion-vars.tf -> Variables para la configuración y corrección
    ├── main.tf      -> Configuración principal sobre Azure, definición de RG, storage account y locals
    ├── network.tf   -> Definicion de Vnet, Subnet y security resource group
    ├── outputs.tf   -> Definición de la salida, para disponer de los valor de las IPs públicas, especialmente
    ├── vm-master.tf -> master nic, pip, vm y asignación del nsg
    ├── vm-nfs.tf    -> nfs nic, pip, vm y asignación del nsg
    └── vm-worker.tf -> workwer nic, pip, vm y asignación del nsg
```
