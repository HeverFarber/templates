
# updated by env0 cloud to code
resource "aws_iam_policy" "policy" {
  name        = "drfit_test_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DrDrDr*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "policy_2" {
  name        = "drfit_test_policy_2"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "ec2:Start*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

module my_module {
  source = "./module"
}
