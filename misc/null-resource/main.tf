variable "counter" {
  type = number
  default = 6
}

resource "null_resource" "null" {
  count = var.counter
}

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "8.2.2"
    }
  }
}