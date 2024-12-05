#cloud-config
hostname: ${hostname}
timezone: Australia/Melbourne
users:
  - name: ansible
    groups: [adm, sudo]
    lock-passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    passwd: <sha-512-password>
    # - or -
    # ssh_authorized_keys:
    #   - your-ssh-key
runcmd:
  - echo 'ansible ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ansible
  - chmod 440 /etc/sudoers.d/ansible
  - usermod -aG docker ansible
final_message: "The system is finally up, after $UPTIME seconds"