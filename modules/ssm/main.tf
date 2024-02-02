resource "aws_ssm_parameter" "cloudwath_config_file" {
  name  = "AmazonCloudWatch-linux-Tailscale"
  type  = "String"
  value = file("${path.module}/config.json")
}
