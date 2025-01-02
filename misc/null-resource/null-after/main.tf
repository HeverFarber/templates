resource "null_resource" "resource" {}

module "my_sub_module" {
  source = "../null-new"
}

resource "random_string" "random" {
  for_each = tomap({
    one_random = 2
    two_random = 4
  })

  length = each.value
}
