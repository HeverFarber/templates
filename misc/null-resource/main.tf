variable "counter" {
  type = number
  default = 87
}

resource "null_resource" "null" {
  count = var.counter
}
