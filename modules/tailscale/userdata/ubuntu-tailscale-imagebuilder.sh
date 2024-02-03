#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# CloudWatch Agent
ssmParameterName=AmazonCloudWatch-linux-Tailscale
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:$ssmParameterName -s
