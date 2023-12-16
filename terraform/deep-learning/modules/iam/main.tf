resource "aws_iam_role" "dlami_admin" {
  name               = "dmami-admin"
  path               = "/"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dlami_admin" {
  role = aws_iam_role.dlami_admin.name
  policy_arn = data.aws_iam_policy.administrator-policy.arn
}

resource "aws_iam_instance_profile" "dlami_admin" {
  name = "dlami-admin-instance-profile"
  role = aws_iam_role.dlami_admin.name
  depends_on = [aws_iam_role.dlami_admin]
}
