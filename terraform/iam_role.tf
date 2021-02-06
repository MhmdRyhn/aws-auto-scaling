resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${local.resource_name_prefix}-ec2-instance-profile"
  path = "/"
  role = aws_iam_role.ec2_role.name
}


resource "aws_iam_role" "ec2_role" {
  name               = "${local.resource_name_prefix}-ec2-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2_role_policy_document.json
}


resource "aws_iam_role_policy" "ec2_inline_policy" {
  name   = "${local.resource_name_prefix}-ec2-inline-policy"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2_policy_document.json
}
