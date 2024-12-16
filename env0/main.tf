terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
  api_key    = var.env0_api_key    # or use ENV0_API_KEY
  api_secret = var.env0_api_secret # or use ENV0_API_SECRET
  api_endpoint = "https://api-pr17199.dev.env0.com"
}

data "env0_template" "example" {
  name = "Misc"
}

data "env0_project" "default_project" {
  name = "My First Project"
}

resource "env0_environment" "example" {
  name        = "environment - TF"
  project_id  = data.env0_project.default_project.id
  template_id = data.env0_template.example.id
  force_destroy = true
  approve_plan_automatically = true
}

/*resource "random_string" "random" {
  count = 500
  length           = 3000
  special          = true
}*/

/*resource "env0_configuration_variable" "variable" {
  count = 300
  name        = "ENVIRONMENT_VARIABLE_NAME_${count.index}"
  is_sensitive = true
  value       = random_string.random[count.index].result
  project_id  = data.env0_project.default_project.id
}
*/
