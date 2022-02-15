provider "aws" {
  region = local.region
}

# db subnet group should be something pre-configed
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = local.db_subnet_group_name
  subnet_ids = local.db_subnet_ids
  tags = merge(
    local.tags,
    {
      "Name" = local.db_subnet_group_name
    },
  )
}

module "postgres01" {
  source = "./modules/aws-rds-postgres"

  vpc_id                   = local.vpc_id
  ingress_with_cidr_blocks = local.ingress_with_cidr_blocks
  egress_with_cidr_blocks  = local.egress_with_cidr_blocks

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  identifier              = local.identifier
  engine_version          = local.engine_version
  family                  = local.family
  instance_class          = local.instance_class
  storage_type            = local.storage_type
  iops                    = local.iops
  allocated_storage       = local.allocated_storage
  max_allocated_storage   = local.max_allocated_storage
  username                = local.username
  password                = local.password
  port                    = local.port
  multi_az                = local.multi_az
  maintenance_window      = local.maintenance_window
  backup_window           = local.backup_window
  backup_retention_period = local.backup_retention_period
  parameters              = local.parameters

  tags = local.tags
}
