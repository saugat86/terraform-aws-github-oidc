locals {
  # Just extra safety incase someone passes in a url with `https://`
  provider_url = replace(var.provider_url, "https://", "")

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
}
