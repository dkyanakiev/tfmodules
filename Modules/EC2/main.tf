# Inputs
# -----------------------------------------------------
variable "ami" {}
variable "instance_type" { }
variable "domain"               { }
variable "key_name"             { }
variable "application_id"       { }
variable "application_code"     { }
variable "environment"          { }
variable "managed_service_tier" { }
variable "security_tier"        { }
variable "infra_msp"            { }
variable "dr_class"             { }
variable "business_unit"        { }
variable "media_bucket"         { }
variable "region"               { }
### TAGS

variable "puppet_role" {}
variable "cpm_backup" {}
variable "arch_compliance" {}
variable "database" {}
variable "puppet_managed" {}
variable "dns_name" {}
variable "nas_mount" {}
variable "saml_domain" {}
variable "volume_size" {}

###
variable  "iam_instance_profile" {} 
variable "subnet_id" {}
variable "sg_ids"         { type = "list" }
variable "user_data_type" { default = "default" }
variable "hostname" { }


# Dependency Modules
# -----------------------------------------------------

data "template_file" "userdata" {
  
  # Extract 2nd letter of the hostname (l/w) to determine which userdata template to use.
  # This code uses Terraform's conditional ternary operator: https://goo.gl/jn3U9u
  

  template = "${ substr(lower(var.hostname), 1, 1) == "l" ? file("${path.module}/data/${var.user_data_type}.sh") : file("${path.module}/data/${var.user_data_type}.ps1") }"
  
  vars {
    hostname = "${var.hostname}"
    installer_bucket = "${var.media_bucket}"
  }
}



# Resources
# -----------------------------------------------------

resource "aws_instance" "instance" {
  
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  monitoring             = true
  vpc_security_group_ids = ["${var.sg_ids}"]
  subnet_id              = "${var.subnet_id}"
  iam_instance_profile   = "${var.iam_instance_profile}"
  user_data              = "${data.template_file.userdata.rendered}"

  
  tags { 
    Name                 = "${var.hostname}"
    host_name            = "${var.hostname}"
    application_id       = "${var.application_id}"
    application_code     = "${var.application_code}"
    ApplicationCode      = "${var.application_code}"
    environment          = "${var.environment}"
    terraform_managed    = "managed"
    security_tier        = "${var.security_tier}"
    infra_msp            = "${var.infra_msp}"
    managed_service_tier = "${var.managed_service_tier}"
    dr_class             = "${var.dr_class}"
    business_unit        = "${var.business_unit}"
    domain               = "${var.domain}"
    puppet_role          = "${var.puppet_role}"
    "cpm backup"         = "${var.cpm_backup}"
    arch_compliance      = "${var.arch_compliance}"
    database             = "${var.database}"
    puppet_managed       = "${var.puppet_managed}"
    dns_name             = "${var.dns_name}.${var.domain}"
    nas_mount            = "${var.nas_mount}"
    saml_domain          = "${var.saml_domain}"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.volume_size}"
    delete_on_termination = false
  }

}


resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {

  alarm_name          = "${var.hostname}-high-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"

  dimensions {
    InstanceId = "${aws_instance.instance.id}"
  }
}


resource "aws_cloudwatch_metric_alarm" "status_alarm" {

  alarm_name          = "${var.hostname}-status-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"
  alarm_description   = "This metric monitors ec2 status checks"

  dimensions {
    InstanceId = "${aws_instance.instance.id}"
  }
}

# Create a CloudWatch alarm with an EC2 Auto-Recover action
resource "aws_cloudwatch_metric_alarm" "recover_ec2_instance" {

  alarm_name          = "${var.hostname}-recover-ec2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Recover EC2 instance after 2 mins"

  dimensions {
    InstanceId = "${aws_instance.instance.id}"
  }
  alarm_actions = ["arn:aws:automate:${var.region}:ec2:recover"]
}


# Outputs
# -----------------------------------------------------

output "name" { value = "${aws_instance.instance.tags.host_name}" }
output "ids"   { value = "${aws_instance.instance.id}" }
output "azs"   { value = "${aws_instance.instance.availability_zone}" }
