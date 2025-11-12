terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

provider "null" {}

provider "null" {
  alias  = "west"
}

variable "counter" {
  type = number
  default = 2
}

resource "null_resource" "null_counter" {
  count = var.counter
}

resource "null_resource" "west_resource" {
  provider = null.west
}

module "my_module_count" {
  count = 2
  source = "./null-after"
}

module "my_module_for" {
  for_each = toset(["one", "two"])

  source = "./null-module"
}

output "my_output" {
  value = "hever3"
}
