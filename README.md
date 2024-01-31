# Tailscale connection AWS RDS


<img src=".assets/tailscale.png" />

https://tailscale.com/kb/1141/aws-rds

https://tailscale.com/kb/1174/install-debian-bookworm
https://tailscale.com/kb/1019/subnets?tab=linux

https://tailscale.com/kb/1021/install-aws#step-8-close-off-your-firewall

```sh
cp config/template.tfvars .auto.tfvars
```


```sh
sudo tailscale up --advertise-routes=10.0.100.0/24,10.0.101.0/24 --accept-dns=false
```

us-west-2.rds.amazonaws.com
10.0.100.2
10.0.101.2