locals {
  region      = "xxxx"
  env         = "xxx"
  proposition = "xxx"

  vpc_id = "xxx"
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "postgresql"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "https"
      cidr_blocks = "10.0.0.0/8"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  db_subnet_group_name = "${local.env}-dbsng"
  db_subnet_ids = ["xxx", "xxxx", "xxx"]

  identifier              = "postgresql01-${local.env}"
  engine_version          = "11.14"
  family                  = "postgres11"
  instance_class          = "db.t3.micro"
  storage_type            = "gp2"
  iops                    = 0
  allocated_storage       = 10
  max_allocated_storage   = 20
  username                = "xxxx"
  password                = "xxxx"
  port                    = 5432
  multi_az                = false
  maintenance_window      = "Mon:01:00-Mon:01:30"
  backup_window           = "01:30-02:00"
  backup_retention_period = 3
  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  tags = {
    Proposition = "${local.proposition}"
    Environment = "${local.env}"
  }
}