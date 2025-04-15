resource "aws_iam_policy" "policy_1" {
  name        = "hever_module_policy_1"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:ABCDE",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "policy_2" {
  name        = "hever_module_policy_2"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:ABCDE1111iii"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
