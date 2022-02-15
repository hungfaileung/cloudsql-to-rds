resource "aws_security_group" "this" {
  name   = local.db_security_group_name
  vpc_id = var.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = local.db_security_group_name
    },
  )
}

resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  count = length(var.ingress_with_cidr_blocks)

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  cidr_blocks = split(
    ",",
    lookup(
      var.ingress_with_cidr_blocks[count.index],
      "cidr_blocks",
      "",
    ),
  )
  description = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "from_port",
    "",
  )
  to_port = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "to_port",
    "",
  )
  protocol = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "protocol",
    "",
  )
}

resource "aws_security_group_rule" "egress_with_cidr_blocks" {
  count = length(var.egress_with_cidr_blocks)

  security_group_id = aws_security_group.this.id
  type              = "egress"
  cidr_blocks = split(
    ",",
    lookup(
      var.egress_with_cidr_blocks[count.index],
      "cidr_blocks",
      "",
    ),
  )
  description = lookup(
    var.egress_with_cidr_blocks[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_cidr_blocks[count.index],
    "from_port",
    "",
  )
  to_port = lookup(
    var.egress_with_cidr_blocks[count.index],
    "to_port",
    "",
  )
  protocol = lookup(
    var.egress_with_cidr_blocks[count.index],
    "protocol",
    "",
  )
}

resource "aws_db_parameter_group" "this" {
  name   = local.db_parameter_group_name
  family = var.family
  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }
  tags = merge(
    var.tags,
    {
      "Name" = local.db_parameter_group_name
    },
  )
}

resource "aws_db_instance" "this" {
  identifier                            = local.db_instance_name
  engine                                = var.engine
  engine_version                        = var.engine_version
  instance_class                        = var.instance_class
  allocated_storage                     = var.allocated_storage
  storage_type                          = var.storage_type
  storage_encrypted                     = true
  username                              = var.username
  password                              = var.password
  port                                  = var.port
  vpc_security_group_ids                = [aws_security_group.this.id]
  db_subnet_group_name                  = var.db_subnet_group_name
  parameter_group_name                  = aws_db_parameter_group.this.name
  multi_az                              = var.multi_az
  iops                                  = var.iops
  maintenance_window                    = var.maintenance_window
  copy_tags_to_snapshot                 = true
  final_snapshot_identifier             = local.db_final_snapshot_identifier
  backup_retention_period               = var.backup_retention_period
  backup_window                         = var.backup_window
  max_allocated_storage                 = var.max_allocated_storage
  deletion_protection                   = true
  delete_automated_backups              = false
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = 7
  performance_insights_kms_key_id       = null
  tags = merge(
    var.tags,
    {
      "Name" = local.db_instance_name
    },
  )
}
