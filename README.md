# Tailscale connection AWS RDS


Current version of this project uses the subnet router for NAT resolution as well, making it a two-purpose single box.

Alternatively, this is an example with separate boxes, which can be adapted with existing code.

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
terraform init
terraform apply -auto-approve
```

Connect to the Tailscale box using SSM:

```sh
aws ssm start-session --target <instance>
```

Check that everything was installed correctly:

```sh
cloud-init status
cat /var/log/cloud-init-output.log
```

Advertise the subnet routes:

```sh
tailscale up --advertise-routes=10.0.0.0/16 --accept-dns=false
```



```ps1
nslookup <rds> 10.0.0.2
```

Add the VPC DNS to the Tailscale namespaces and approve the routes:

> ⚠️ Make sure you approve the routes in the Admin panel

| IP       | Namespace                   |
|----------|-----------------------------|
| 10.0.0.2 | us-east-2.rds.amazonaws.com |


You can disable key expiry as well.


Checking the status of the CloudWatch agent:

```sh
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status
```


```
tailscale ip -4
```

```
sudo apt install speedtest-cli
speedtest-cli --secure
```

```sh
aws ssm send-command \
    --document-name 'AmazonInspector2-ConfigureInspectorSsmPluginLinux	' \
    --targets Key=InstanceIds,Values='i-00000000000000000' \
    --parameters 'Operation=Install,RebootOption=RebootIfNeeded' \
    --timeout-seconds 600
```