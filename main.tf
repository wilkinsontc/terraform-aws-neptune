data "aws_subnet_ids" "this" {
  vpc_id = var.vpc_id
}

resource "aws_neptune_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = data.aws_subnet_ids.this.ids
  tags       = module.tagging.tags
}

data "aws_security_group" "this" {
  name   = var.neptune_security_group_name
  vpc_id = var.vpc_id
}

resource "aws_neptune_cluster_parameter_group" "this" {
  family = var.aws_neptune_cluster_parameter_group.family
  name   = var.aws_neptune_cluster_parameter_group.name
  tags   = module.tagging.tags

  parameter {
    name  = "neptune_query_timeout"
    value = var.neptune_query_timeout
  }

  parameter {
    name  = "neptune_enable_audit_log"
    value = 1
  }
}

resource "aws_neptune_parameter_group" "this" {
  family = var.aws_neptune_parameter_group.family
  name   = var.aws_neptune_parameter_group.name
  tags   = module.tagging.tags

  parameter {
    name  = "neptune_query_timeout"
    value = var.neptune_query_timeout
  }
}

resource "aws_neptune_cluster" "this" {
  apply_immediately                    = var.cluster.apply_immediately
  backup_retention_period              = var.cluster.backup_retention_period
  cluster_identifier                   = var.cluster.cluster_identifier
  enable_cloudwatch_logs_exports       = ["audit"]
  iam_database_authentication_enabled  = var.cluster.iam_database_authentication_enabled
  kms_key_arn                          = var.cluster.kms_key_arn
  neptune_cluster_parameter_group_name = aws_neptune_cluster_parameter_group.this.name
  neptune_subnet_group_name            = aws_neptune_subnet_group.this.name
  preferred_backup_window              = var.cluster.preferred_backup_window
  preferred_maintenance_window         = var.cluster.preferred_maintenance_window
  skip_final_snapshot                  = var.cluster.skip_final_snapshot
  storage_encrypted                    = true
  tags                                 = module.tagging.tags
  vpc_security_group_ids               = [data.aws_security_group.this.id]
}

resource "aws_neptune_cluster_instance" "this" {
  apply_immediately            = var.instance.apply_immediately
  cluster_identifier           = aws_neptune_cluster.this.id
  count                        = var.instance.count
  identifier_prefix            = var.instance.identifier_prefix
  instance_class               = var.instance.instance_class
  neptune_parameter_group_name = aws_neptune_parameter_group.this.name
  neptune_subnet_group_name    = aws_neptune_subnet_group.this.name
  tags                         = module.tagging.tags
}
