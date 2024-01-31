#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

apt update
apt upgrade -y

curl -fsSL https://tailscale.com/install.sh | sh

echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

apt install -y iptables-persistent
iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
iptables-save  > /etc/iptables/rules.v4
