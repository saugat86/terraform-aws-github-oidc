data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  count = var.enabled ? 1 : 0

  statement {
    sid    = "GithubOidcAuth"
    effect = "Allow"
    actions = [
      "sts:TagSession",
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type        = "Federated"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:oidc-provider/${local.provider_url}"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "token.actions.githubusercontent.com:iss"
      values   = ["http://token.actions.githubusercontent.com"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "${local.provider_url}:aud"
      values   = [var.audience]
    }

    condition {
      test     = "StringLike"
      variable = "${local.provider_url}:sub"
      # Strip `repo:` to normalize for cases where users may prepend it
      values = [for subject in var.subjects : "repo:${trimprefix(subject, "repo:")}"]
    }
  }
}
