module "github_oidc_provider" {
  source = "./modules/github-oidc-provider"
  url   = "https://token.actions.githubusercontent.com"

  # https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
  additional_thumbprints = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]
  tags  = local.tags
}


module "github_oidc_role" {
  source = "./modules/github-oidc-iam-role"
  name = "github_oidc"
  subjects = [
    "repo:saugat86/*",
  ]
  policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  tags  = local.tags
}