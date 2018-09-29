####
## Done
####

variable "iam_role_name"          { } ### abc_uid1234567_app_admin
variable "account_id"         { }
variable "application_code"   { }
variable "application_uid"     { }
variable "autopark_s3_bucket" { }
variable "app_data_bucket"    { }

variable "assume_role_name" { } # federated,auditor,architect

variable "policy_name" { } # ccna_admin,ccna_developer,content_contributor,default,ko_admin

data "template_file" "assume_role" {
 
  template = "${file("${path.module}/data/assume_role/${var.assume_role_name}.json")}"

  vars {
    account_id       = "${var.account_id}"
    application_code = "${var.application_code}"
    application_id   = "${var.application_uid}"
    autopark_bucket  = "${var.autopark_s3_bucket}"
  }
}

data "template_file" "inline_policy" {

  template = "${file("${path.module}/data/policy/${var.policy_name}.json")}"

  vars { 
    account_id       = "${var.account_id}"
    application_code = "${var.application_code}"
    application_id   = "${var.application_uid}"
    autopark_bucket  = "${var.autopark_s3_bucket}"
    app_data_bucket  = "${var.app_data_bucket}"
  }
}


resource "aws_iam_role" "role" {

  name               = "${var.iam_role_name}"
  assume_role_policy = "${data.template_file.assume_role.rendered}"
  provisioner "local-exec" {
    command = "sleep 60"
  }

}


resource "aws_iam_role_policy" "inline" {

  name   = "${var.iam_role_name}-${var.policy_name}"
  role   = "${aws_iam_role.role.name}"
  policy = "${data.template_file.inline_policy.rendered}"
  
  #depends_on = ["aws_iam_role.role.unique_id"]
}
