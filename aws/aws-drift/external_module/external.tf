resource "aws_iam_policy" "policy_1" {
  name        = "hever_external_module_policy_1"
  path        = "/"
  description = "My test policy"

  policy = var.policy_statement
}

variable "policy_statement" {}

module my_module {
  source = "./internal-module"
}
