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


# sysctl -w net.ipv4.ip_forward=1
# sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
# sysctl -p

# apt install -y iptables-persistent
# iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
# iptables-save  > /etc/iptables/rules.v4


reboot
