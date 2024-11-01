# ssh_password = "$6$2ID.IeBOrsxtxC38$vumdV8efDUg/iwp21jN65LTKCxHnaG3TBfu0aOMQC/LHSyAHo8SNBEvXjVvPw0bHpGcrxSy926H.DBBGRmJwl0"
# vm_user = "phip"
# vm_name = "ubuntu-server-focal"
proxmox_api_url = "https://192.168.0.48:8006/api2/json"  # Your Proxmox IP Address
proxmox_api_token_id = "root@pam!terraform2"  # API Token ID
proxmox_api_token_secret = "488c0bba-e761-48b5-8a4d-c2bae04d880c"

node = "boss"
vm_id = "250"
vm_name = "ubuntu-server-24.04-focal-docker-test"
template_description = "Ubuntu Server Focal (24.01) Image"

disk_size= "20G"
cores = 4
memory = 4096

ssh_username ="phip"
ssh_password ="test12345678!&%#"


# Rest of the code...