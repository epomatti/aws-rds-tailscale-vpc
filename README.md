# Tailscale connection AWS RDS


<img src=".assets/tailscale.png" />

https://tailscale.com/kb/1141/aws-rds

https://tailscale.com/kb/1174/install-debian-bookworm
https://tailscale.com/kb/1019/subnets?tab=linux

https://tailscale.com/kb/1021/install-aws#step-8-close-off-your-firewall

https://tailscale.com/kb/1235/resolv-conf?q=dns
https://repost.aws/questions/QUlEvYKkbUSNmZCiNJFcMpCA/aws-ec2-ubuntu-22-04-dns-issues-with-tailscale

https://tailscale.com/blog/how-tailscale-works


https://www.devzero.io/docs/how-can-i-connect-to-an-aws-rds-database  

```sh
cp config/template.tfvars .auto.tfvars
```

```sh
aws ssm start-session --target <instance>
```


```sh
tailscale up --advertise-routes=10.0.100.0/24,10.0.101.0/24 --accept-dns=false

# tailscale up --advertise-routes=10.0.100.0/24,10.0.101.0/24,10.0.55.0/24 --accept-dns=false
```

```ps1
nslookup <rds> 10.0.55.2
```

Approve the subnet routes

| IP         | Namespace                   |
|------------|-----------------------------|
| 10.0.100.2 | us-east-2.rds.amazonaws.com |
| 10.0.101.2 | us-east-2.rds.amazonaws.com |


```
tailscale ip -4
```

```
sudo apt install speedtest-cli
speedtest-cli --secure
```