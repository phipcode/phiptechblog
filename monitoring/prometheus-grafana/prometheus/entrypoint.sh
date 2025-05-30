#!/bin/sh

# Create the Proxmox Exporter systemd service file
cat <<EOL > /etc/systemd/system/prometheus-pve-exporter.service
[Unit]
Description=Prometheus Proxmox VE Exporter
Documentation=https://github.com/prometheus-pve/prometheus-pve-exporter

[Service]
Restart=always
User=pve-exporter
ExecStart=/opt/prometheus-pve-exporter/bin/pve_exporter --config.file /etc/prometheus/pve.yml

[Install]
WantedBy=multi-user.target
EOL

# Set permissions for the service file
chown root:root /etc/systemd/system/prometheus-pve-exporter.service
chmod 644 /etc/systemd/system/prometheus-pve-exporter.service

# Set ownership and permissions for pve.yml
chown -v root:pve-exporter /etc/prometheus/pve.yml
chmod -v 640 /etc/prometheus/pve.yml

# Start Prometheus
exec prometheus --config.file=/etc/prometheus/prometheus.yml
