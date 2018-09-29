IAM Module Suite
================

There are multiple IAM related modules belonging to this suite. Each module is described in their respective sections:


# iam_roles

This module is used to create N IAM roles.


## Inputs

| Name                 | Description                                                              |
|----------------------|--------------------------------------------------------------------------|
| application_id       | The assigned Application ID for the server group                         |
| application_code             | The assigned Application Code for the server group                       |
| account_id           | The ID of the AWS account                                                |
| autopark_s3_bucket   | The name of the S3 bucket, where autopark data is stored                 |
| iam_roles            | A List of IAM roles properties (see _iam_roles_ table below)             |


### iam_roles

The following table describes the fields that each item in the _iam_roles_ variable list should contain. Each item represents a single role. These fields are passed as a comma-separated list of variables

| Field Name       | Description                                          |
|------------------|------------------------------------------------------|
| role_name        | The name of the role                                 |
| inline_policy    | 



# iam_profiles

This module is used to create N IAM instance profiles. 



# iam_policy_arn_attachments

This module is used to attach additional IAM policies to existing IAM Roles


