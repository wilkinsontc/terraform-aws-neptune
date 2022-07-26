<!-- BEGIN_TF_DOCS -->
## Simple Example
```hcl
module "neptune" {
  source  = "github.com/ICSEng/terraform-aws-neptune"

  cluster = {
    apply_immediately                   = true
    backup_retention_period             = 5
    cluster_identifier                  = "simple-neptune-cluster"
    iam_database_authentication_enabled = true
    preferred_backup_window             = "07:00-09:00"
    preferred_maintenance_window        = "wed:04:00-wed:09:00"
    kms_key_arn                         = ""
    skip_final_snapshot                 = true
  }

  instance = {
    apply_immediately = true
    count             = 2
    instance_class    = "db.r4.large"
  }

  vpc_id                = data.aws_vpc.this.id
  neptune_query_timeout = 120000
  sn_tags               = var.sn_tags
}

data "aws_vpc" "this" {
  tags = {
    region_priority = 1
  }
}
```
<!-- END_TF_DOCS -->
