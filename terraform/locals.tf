locals {
  resource_name_prefix = "${var.prefix}${var.service == "" ? "" : "-"}${var.service}-${var.environment}"
  dynamodb_table_name  = "user-profile"
}


locals {
  http = {
    protocol = "HTTP"
    port     = 80
  }
}


locals {
  asg_enabled_metrics = [
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


locals {
  build_dir = "${path.module}/../.build"
  common_tags = merge(
    {
      Application = var.prefix
      Environemnt = var.environment
    },
    zipmap(
      compact([var.service == "" ? "" : "Service"]),
      compact([var.service])
    )
  )
}
