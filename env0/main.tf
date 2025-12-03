terraform {
  required_providers {
    env0 = {
      version = "6.6.6"
      source  = "terraform.env0.com/local/env0"
    }
/*    env0 = {
      source  = "env0/env0"
      version = "1.27.0"
    }*/
  }
}

provider "env0" {
  api_key    = var.env0_api_key    # or use ENV0_API_KEY
  api_secret = var.env0_api_secret # or use ENV0_API_SECRET
  api_endpoint = "https://api-dev.dev.env0.com"
}

/*data "env0_template" "example" {
  name = "Misc"
}

data "env0_project" "default_project" {
  name = "My First Project"
}*/

/*resource "env0_environment" "example" {
  name        = "environment - TF"
  project_id  = data.env0_project.default_project.id
  template_id = data.env0_template.example.id
  force_destroy = true
  approve_plan_automatically = true
}*/

/*data "env0_template" "sub_environment_null_template" {
  name = "null resource"
}*/



resource "env0_template" "workflow_template" {
  name              = "Template for workflow"
  type              = "workflow"
  repository        = "https://github.com/env0/templates"
  path              = "misc/single-environment-workflow"
}

resource "env0_template_project_assignment" "assignment_sub_environment_null_template" {
  template_id = env0_template.workflow_template.id
  project_id  = "fe6b5068-808d-4103-8b28-d35d48bda2ec"
}

resource "env0_environment" "workflow-environment" {
  depends_on = [
    env0_template_project_assignment.assignment_sub_environment_null_template
  ]

  force_destroy = true
  name          = "environment-workflow-test"
  project_id    = "fe6b5068-808d-4103-8b28-d35d48bda2ec"
  template_id   = env0_template.workflow_template.id

  configuration {
    name  = "n1"
    value = "v1"
  }

  sub_environment_configuration {
    alias                      = "rootService1"
    approve_plan_automatically = true

    configuration {
      name  = "sub_env1_var1"
      value = "hello"
    }
    configuration {
      name  = "sub_env1_var2"
      value = "world-new"
    }

    configuration {
      name  = "sub_env3_var3"
      value = "hever"
    }
  }
}

resource "env0_configuration_variable" "variable1" {
  name        = "VARIABLE_1"
  is_sensitive = true
  value       = "value1"
  project_id  = "fe6b5068-808d-4103-8b28-d35d48bda2ec"
}

resource "env0_configuration_variable" "variable3" {
  name        = "VARIABLE_3"
  is_sensitive = true
  value       = "value3"
  project_id  = "fe6b5068-808d-4103-8b28-d35d48bda2ec"
}

resource "env0_configuration_variable" "variable4" {
  name        = "VARIABLE_4"
  value       = "value4"
}

resource "env0_configuration_variable" "variable5" {
  name        = "VARIABLE_5"
  value       = "value5"
}

resource "env0_configuration_variable" "variable2" {
  name        = "VARIABLE_2"
  is_sensitive = false
  value       = "value2"
  project_id  = "fe6b5068-808d-4103-8b28-d35d48bda2ec"
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

import {
  to = env0_template.hever
  id = "7bb9e560-6c42-4477-8fa1-38211b606154"
}

resource "env0_template" "hever" {
  name             = "AWS Drift"
  type             = "opentofu"
  opentofu_version = "latest"

  repository      = "https://github.com/HeverFarber/templates"
  // vcs_connection_id = "3ed69d3f-8243-4f5b-8799-1d43269c91c7"
  path            = "aws/aws-drift"
  github_installation_id = "27896314"
}

import {
  to = env0_template.packops_bc
  id = "3ae74061-f0db-4951-a945-1847c39bc8f8"
}

resource "env0_template" "packops_bc" {
  name             = "AzureDevOps - Test"
  type             = "terraform"
  description      = "Creates infrastructure for a region of the"
  terraform_version = "1.5.7"
  opentofu_version = "latest"

  repository      = "https://dev.azure.com/env0-test-org/elbaz/_git/elbaz"
  is_azure_devops = true
  path            = "misc/null-resource"
  revision        = "main"
  token_id        = "f1b9796a-f9d3-48ae-a198-1249db012b6f"
}

resource "env0_template" "custom_roles_workflow" {
  name             = "59-custom-roles-workflow"
  type             = "workflow"
  description      = "Workflow for custom roles"
  opentofu_version = "latest"

  repository      = "https://dev.azure.com/env0-test-org/elbaz/_git/elbaz"
  is_azure_devops = true
  path            = "misc/null-resource"
  revision        = "main"
  token_id        = "f1b9796a-f9d3-48ae-a198-1249db012b6f"
}

import {
  to = env0_template.custom_hever
  id = "de70e299-628e-416e-9257-8fb4e27c2c9e"
}

resource "env0_template" "custom_hever" {
  name             = "custom-roles-hever"
  type             = "workflow"
  description      = "Workflow for custom roles"
  opentofu_version = "latest"

  repository      = "https://dev.azure.com/env0-test-org/elbaz/_git/elbaz"
  is_azure_devops = true
  path            = "misc/null-resource"
  revision        = "main"
  token_id        = "f1b9796a-f9d3-48ae-a198-1249db012b6f"
}
