resource "null_resource" "null-new" {
}

data "null_data_source" "data-new" {
  inputs = {
    hever = "hever"
  }
}

output "my_value_new" {
  value = "hever"
}
