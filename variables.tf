variable "cluster" {
  type = object(
    {
      apply_immediately                   = bool
      backup_retention_period             = number
      cluster_identifier                  = string
      iam_database_authentication_enabled = bool
      kms_key_arn                         = string
      preferred_backup_window             = string
      preferred_maintenance_window        = string
      skip_final_snapshot                 = bool
    }
  )
  description = "Neptune Cluster data"
}

variable "instance" {
  type = object(
    {
      apply_immediately = bool
      count             = number
      identifier        = string
      instance_class    = string
    }
  )
  default = {
    apply_immediately = true
    count             = 2
    identifier        = "instance"
    instance_class    = "db.r4.large"
  }
  description = "Neptune Instance data"
}

variable "subnet_group_name" {
  type        = string
  default     = "main"
  description = "Name of the subnet group"
}

variable "vpc_id" {
  type        = string
  description = "Security Group needs to know where to be made"
}

variable "aws_neptune_parameter_group" {
  type = object(
    {
      family  = string
      name    = string
    }
  )

  default = {
    family  = "neptune1"
    name    = "example"
  }

  description = "Values for the neptune parameter group"
}

variable "neptune_query_timeout" {
  type        = number
  description = "Timeout value for neptune queries in millisecond"
}

variable "neptune_security_group_name" {
  type        = string
  default     = "neptune_sg"
  description = "Name of the security group for neptune"
}

###########################   Tags    #########################################################
variable "sn_tags" {
  type        = map(string)
  default     = {}
  description = "The service now tags that come from the devops pipeline.  Declare the variable \"sn_tags\" of type map(string) in your own project to get them"
}

variable "billing_token" {
  type        = string
  default     = null
  description = "billing token defined by finance to track cloud resources"
}

variable "other_tags" {
  type        = map(string)
  default     = {}
  description = "Other tags to be used on these resources beyond what ServiceNow provides"
}
