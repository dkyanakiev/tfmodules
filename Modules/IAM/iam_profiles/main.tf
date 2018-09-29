##
#Profiles
##
variable "iam_profiles"     { } ### abc-uid100120120-prod 
variable "account_id"       { }
variable "application_code" { }
variable "application_uid"   { }
variable "media_bucket"     { }
variable "app_data_bucket"  { }

variable "profile_assume_role" { } 


data "template_file" "assume_role" {
  
  template = "${file("${path.module}/data/assume_role/${var.profile_assume_role}.json")}"

  vars {
    account_id           = "${var.account_id}"
    application_code     = "${var.application_code}"
    application_uid       = "${var.application_uid}"
    media_bucket         = "${var.media_bucket}"
    app_data_bucket      = "${var.app_data_bucket}"
  }
}

resource "aws_iam_role" "role" {

  name               = "${var.iam_profiles}"
  assume_role_policy = "${data.template_file.assume_role.rendered}"
  provisioner "local-exec" {
    command = "sleep 30"
  }
}


resource "aws_iam_instance_profile" "profile" {

  name   = "${var.iam_profiles}"
  role   = "${aws_iam_role.role.name}"

}
