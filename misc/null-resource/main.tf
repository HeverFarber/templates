variable "counter" {
  type = number
  default = 6
}

resource "null_resource" "null" {
  count = var.counter
}

terraform {
  required_version  = "=1.6.0"
}