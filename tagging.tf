module "tagging" {
  source = "app.terraform.io/ICS/tagging/tagging"
  version = "1.3.1"

  # Required
  sn_tags                = var.sn_tags
  tag_billing_token      = var.billing_token
  aws_tags               = true

  #Optional
  other_tags = var.other_tags
}
