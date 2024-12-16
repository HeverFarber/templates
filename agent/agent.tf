terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.0"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = "kushield-new"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "kushield-new"]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "kushield-new"]
      command     = "aws"
    }
  }
}

resource "helm_release" "agent" {
  name             = "env0-agent"
  namespace        = "env0-agent-hever2"
  create_namespace = true
  chart            = "/Users/heverfarber/Env0/env0-repo/agent/helm/"
  timeout          = 600
  wait             = false
  values = [yamlencode({
    "agentKey" : "pr17415-kushield"
    "apiGatewayUrl" : "https://pr17415-kushield.agent.dev.env0.com/pr17415-kushield"
    "awsAccessKeyIdEncoded" : "QUtJQVNQTExGVVRPREdXTVlDNUQ="
    "awsSecretAccessKeyEncoded" : "aGprTTBveGhKQkhIeDIycTJyREN4d3VYZjNGYTN2SkRMdkQrbUlTZw=="
    "env0ApiGwKeyEncoded" : "TlNvUmlsclljTjVCZDdUWXhoRW95NUdkYVcwbmFKU3YxZFlPaTZqYw=="
    "isSelfHosted" : "true"
    "outputLogsLogGroupName" : "prerequisites-dev-k8s-shag-logs"
    "stage" : "pr17415"
    dockerImage : "ghcr.io/env0/deployment-agent:dev",
    force_helm_upgrade : uuid()
  })]
}
