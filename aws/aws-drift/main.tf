terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}
resource "null_resource" "my" {}

resource "aws_iam_policy" "policy_1" {
  name        = "hever_policy_1"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:ABCDENewNewn Alon",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "policy_2" {
  name        = "hever_policy_2"
  path        = "/"
  description = "My test policy"

  policy = local.policy_statement
}


module my_module {
  source = "./module"
}

module "external_module" {
  source = "github.com/HeverFarber/templates//aws/aws-drift/external_module"

  policy_statement = {
    Statement = [
      {
        Action   = ["ec2:ABCDE hever"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
}
