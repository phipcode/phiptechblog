vms = {
 "prod-test-01" = {
    clone       = "ubuntu-server-focal-docker-micro"
    vm_name     = "prod-test-01"
    name        = "prod-test-01"
    vm_cores    = 4
    vm_memory   = 4096
    disk_size   = "20G"
    vm_id       = 500
    target_node = "proxmicro"
    storage      = "vm-storage" #storage pool
 }
}

