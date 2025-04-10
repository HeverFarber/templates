locals {
  policy_stetment = jsonencode({
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


resource "aws_iam_policy" "policy_3" {
  name        = "hever_module_policy_3"
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

resource "aws_iam_policy" "policy_4" {
  name        = "hever_module_policy_4"
  path        = "/"
  description = "My test policy"
  policy      = "{\"Statement\":[{\"Action\":[\"ec2:A\"],\"Effect\":\"Allow\",\"Resource\":\"*\"}],\"Version\":\"2012-10-17\"}"
}
