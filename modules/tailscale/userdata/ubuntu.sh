#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

apt update
apt upgrade -y

# NAT - https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html
sysctl -w net.ipv4.ip_forward=1

# Set the forwarding permanently
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p

apt install -y iptables-persistent
iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
iptables-save  > /etc/iptables/rules.v4


reboot
