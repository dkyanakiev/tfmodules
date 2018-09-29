variable "ami" { default = "ami-36f7a656" }
variable "instance_type" { default = "t2.micro"}
variable "domain"               { default = "na.ko.com"}
variable "key_name"             { default = "Test_key"}
variable "application_id"       { default = "uid1012001"}
variable "application_code"     { default = "abv"}
variable "environment"          { default = "prod"}
variable "managed_service_tier" { default = "3"}
variable "security_tier"        { default = "2"}
variable "infra_msp"            { default = "1"}
variable "dr_class"             { default = "2"}
variable "business_unit"        { default = "ko"}
variable "media_bucket"         { default = "mediabucket"}
variable "region"               { default = "us-east-1"}
### TAGS

variable "puppet_role" { default = "managed"}
variable "cpm_backup" { default = "3" }
variable "arch_compliance" { default = "ok" }
variable "database" { default = "no" }
variable "puppet_managed" { default = "managed" }
variable "dns_name" { default = "dns"}
variable "nas_mount" { default = "nas"}
variable "saml_domain" { default = "na.ko.com"}
variable "volume_size" { default = "20"}

###
variable  "iam_instance_profile" { default = "abc-uid101232131213-prod"} 
variable "subnet_id" { default = "subnet-9cfe70c5"}
variable "sg_ids"         { default = ["sg-7ee74b19","sg-e1e3b886"] }
variable "user_data_type" { default = "default" }
variable "hostname" { default = "clptfma0001" }

module "instance1" {
    source = "/Users/o34579/TCCC/Dev/Playground/ModuleTest/Modules/EC2"

    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    domain = "${var.domain}"
    key_name = "${var.key_name}"
    application_id = "${var.application_id}"
    application_code = "${var.application_code}"
    environment = "${var.environment}"
    managed_service_tier = "${var.managed_service_tier}"
    security_tier = "${var.security_tier}"
    infra_msp = "${var.infra_msp}"
    dr_class = "${var.dr_class}"
    business_unit = "${var.business_unit}"
    media_bucket = "${var.media_bucket}"
    region = "${var.region}"
    puppet_role = "${var.puppet_role}"
    cpm_backup = "${var.cpm_backup}"
    arch_compliance = "${var.arch_compliance}"
    database = "${var.database}"
    puppet_managed = "${var.puppet_managed}"
    dns_name = "${var.dns_name}"
    nas_mount = "${var.nas_mount}"
    saml_domain = "${var.saml_domain}"
    volume_size = "${var.volume_size}"

    iam_instance_profile = "${var.iam_instance_profile}"
    subnet_id = "${var.subnet_id}"
    sg_ids = "${var.sg_ids}"
    user_data_type = "${var.user_data_type}"
    hostname = "${var.hostname}"

}

output "instance1_name" { value = "${module.instance1.name}"}

output "instance1_id" { value = "${module.instance1.ids}"}