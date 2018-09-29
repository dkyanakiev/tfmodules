
# Inputs
# -----------------------------------------------------
variable "application_id"               { }
variable "application_code"             { }
variable "environment"          { }
variable "managed_service_tier" { }
variable "security_tier"        { }
variable "infra_msp"            { }
variable "dr_class"             { }
variable "business_unit"        { }

variable "ec2_ids"   { type = "list" }
variable "ec2_azs"   { type = "list" }
# variable "kms_names" { type = "list" }
# variable "kms_arns"  { type = "list" }
# #variable "kms_key_id" { }
variable "cpm_backup" { }

variable "ebs_name" { }

variable "ebs_type" { }

variable "size" { }

variable "iops" { }

variable "encrypted" {default = "true"}

variable "availability_zone" { }
variable "device_name" {}
variable "instance_id" { }

# Resources
# -----------------------------------------------------

resource "aws_ebs_volume" "ebs_volume" {  

  type              = "${var.ebs_type}"
  size              = "${var.size}"
  iops              = "${var.iops}"
  availability_zone = "${var.availability_zone}"
  encrypted         = "${var.encrypted}"
 # kms_key_id        = "${lookup(zipmap(var.kms_names,var.kms_arns), element(split(",", element(var.volumes, count.index)), 6), "")}"


  tags {
    Name                 = "${var.ebs_name}"
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
    "cpm backup"         = "${var.cpm_backup}"
  }
}


resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "${var.device_name}"
  volume_id   = "${aws_ebs_volume.ebs_volume.id}"
  instance_id = "${var.instance_id}"
}



# Outputs
# -----------------------------------------------------

output "ebs_name"   { value = "${join(",", aws_ebs_volume.ebs_volume.tags.Name)}" }
output "ebs_ids"     { value = "${join(",", aws_ebs_volume.ebs_volume.id)}" }
