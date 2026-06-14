terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.12.1"
    }
  }

  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "github-actions"
  }
}

# 認証は環境変数 GITHUB_TOKEN（repo / admin:org スコープ相当）から行う。
provider "github" {
  owner = var.github_owner
}
