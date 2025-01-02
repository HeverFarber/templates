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

resource "null_resource" "null" {
  count = var.counter
}

resource "null_resource" "null1" {
  provider = null.west
}

resource "null_resource" "null2" {
  provider = null.west
}

module "my_module_new_hever" {
  count = 2
  source = "./null-after"
}


output "my_value_main" {
  value = "hever2"
}
