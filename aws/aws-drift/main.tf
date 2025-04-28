terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}
resource "null_resource" "my" {}

<<<<<<< HEAD
=======
resource "aws_secretsmanager_secret" "GITHUB_BOT_APP_SECRET" {
  name = "hever-test"
  policy = "{\"Statement\":[{\"Action\":\"secretsmanager:GetSecretValue\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::326535729404:root\"},\"Resource\":\"*\"}],\"Version\":\"2012-10-17\"}"
  tags = {
    NewTag = "9999"
    myTag = "1111"
  }
  tags_all = {
    NewTag = "9999"
    myTag = "1111"
  }
}

resource "aws_secretsmanager_secret_version" "GITHUB_BOT_APP_SECRET" {
  secret_id     = aws_secretsmanager_secret.GITHUB_BOT_APP_SECRET.id
  secret_string = "hever-test-secret"
}

>>>>>>> origin/master
resource "aws_iam_policy" "policy_1" {
  name        = "hever_policy_1"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:ABCDENewNewn dsdfewdsfd",
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

module external_module {
  source = "github.com/HeverFarber/templates//aws/aws-drift/external_module"

  policy_statement = local.policy_statement
}
