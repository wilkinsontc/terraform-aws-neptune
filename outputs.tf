output "instances" {
  value = aws_neptune_cluster_instance.this
}

output "cluster" {
  value = aws_neptune_cluster.this
}

output "subnet" {
  value = aws_neptune_subnet_group.this
}

output "security_group" {
  value = data.aws_security_groups.this
}
