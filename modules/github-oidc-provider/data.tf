data "aws_partition" "current" {}
data "tls_certificate" "this" {
  count = var.enabled ? 1 : 0
  url   = var.url
}
