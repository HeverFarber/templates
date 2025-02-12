provider "aws" {
  region  = "us-east-2"
}

provider "aws" {
  alias = "hever-2"
  region  = "us-east-1"
}


/*data "aws_secretsmanager_secret" "secret" {
  name = var.secret_name
}*/

data "aws_caller_identity" "current" {}

data "aws_region" "west" {
  name = "eu-west-1"
}

data "aws_region" "hever" {
    provider = aws.hever-2
}

variable "secret_name" {
  default = "secret-ref"
}
