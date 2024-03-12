variable "counter" {
  type = number
  default = 6
}

resource "null_resource" "null" {
  count = var.counter
}

terraform {
  required_version  = "<0.12.3, >= 0.10.0"
}