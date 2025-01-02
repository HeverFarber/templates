resource "null_resource" "null-resource_count_one" {
  count = 1
}

data "null_data_source" "data-resource" {
  inputs = {
    hever = "hever"
  }
}

output "my_output" {
  value = "hever"
}
