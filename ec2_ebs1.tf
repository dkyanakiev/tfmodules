#variable "application_id"               { default = "uid1012001"}
#variable "application_code"             { default = "abv"}
#variable "environment"          { default = "prod"}
#variable "managed_service_tier" { default = "3"}
#variable "security_tier"        { default = "2"}
#variable "infra_msp"            { default = "1"}
#variable "dr_class"             { default = "2"}
#variable "business_unit"        { default = "ko"}
# variable "volumes"   { type = "list" }
# variable "ec2_names" { type = "list" }
# variable "ec2_ids"   { type = "list" }
# variable "ec2_azs"   { type = "list" }
# variable "kms_names" { type = "list" }
# variable "kms_arns"  { type = "list" }
# #variable "kms_key_id" { }
#variable "cpm_backup" { default = "3" }

variable "ebs_name" { default = "ebs-vol1"}

variable "ebs_type" { default = "io1" }

variable "size" { default = "20"}

variable "iops" { default = "1000"}

variable "encrypted" {default = "true"}

variable "availability_zone" { default = "ez2"}

variable "randomid" { default = "${module.instance1.instance1_id}"}

variable "device_name" {default = "/dev/sdb"}

module "ec2ebs1" {

    source = "/Users/o34579/TCCC/Dev/Playground/ModuleTest/Modules/EBS"

        application_id = "${var.application_id}"
        application_code = "${var.application_code}"
        environment = "${var.environment}"
        managed_service_tier = "${var.managed_service_tier}"
        security_tier = "${var.security_tier}"
        infra_msp = "${var.infra_msp}"
        dr_class = "${var.dr_class}"
        business_unit = "${var.business_unit}"
       # kms_names
       # kms_arns
       # kms_key_id
        cpm_backup = "${var.cpm_backup}"
        ebs_name = "${var.ebs_name}"
        ebs_type = "${var.ebs_type}"
        size = "${var.size}"
        iops = "${var.iops}"
        encrypted = "${var.encrypted}"
        device_name = "${var.device_name}"
        availability_zone = "${var.availability_zone}"
     #   instance_id = "${var.instance1_id}"

        instance_id = "${var.randomid}"
}