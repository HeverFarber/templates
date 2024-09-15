variable "counter" {
  type = number
  default = 6
}

resource "null_resource" "null" {
  count = var.counter
}

output "token_value" {
 value = "secret1"
 sensitive = true
}

output "none_value" {
 value = "clear"
}
