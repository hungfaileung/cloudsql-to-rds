locals {
  db_parameter_group_name      = "${var.identifier}-dbpg"
  db_final_snapshot_identifier = "${var.identifier}-final-snapshot"
  db_security_group_name       = "${var.identifier}-sg"
  db_instance_name             = "${var.identifier}-db"
}
