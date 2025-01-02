resource "null_resource" "null2" {
}

module "my_module_new" {
  source = "../null-new"
}
