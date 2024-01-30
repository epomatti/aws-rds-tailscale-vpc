#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

apt update
apt upgrade -y

### SSM Agent ###
region=us-east-2

mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.$region.amazonaws.com/amazon-ssm-$region/latest/debian_arm64/amazon-ssm-agent.deb
dpkg -i amazon-ssm-agent.deb
systemctl status amazon-ssm-agent

### Tailscale ###
curl -fsSL https://tailscale.com/install.sh | sh

echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

# TODO: https://github.com/tailscale/tailscale/issues/3416
# firewall-cmd --permanent --add-masquerade


sudo tailscale up --advertise-routes=10.0.100.0/24,10.0.101.0/24,10.0.1.0/24 --accept-dns=false
#  --accept-dns=false




# sysctl -w net.ipv4.ip_forward=1
# sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
# sysctl -p

# apt install -y iptables-persistent
# iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
# iptables-save  > /etc/iptables/rules.v4


reboot
