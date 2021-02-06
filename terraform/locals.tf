locals {
  resource_name_prefix = "${var.prefix}-${var.environment}"
  dynamodb_table_name  = "user-profile"
}


locals {
  build_dir = "${path.module}/../.build"
}


locals {
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}
