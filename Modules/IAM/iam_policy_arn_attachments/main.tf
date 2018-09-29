
variable "role_name" { } #### abc-uid101232131213-prod
variable "iam_policy_arn_attachments" { } ### arn:aws:iam::${var.account_id}:policy/ko_eec_common_for_instance_profiles 
                                          ### arn:aws:iam::${var.account_id}:policy/ccna_common_for_instance_profiles 

resource "aws_iam_role_policy_attachment" "attachement" {
  role       = "${var.role_name}"
  policy_arn = "${var.iam_policy_arn_attachments}"
}
