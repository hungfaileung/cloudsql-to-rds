output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.postgres01.db_instance_address
}

output "db_instance_port" {
  description = "The database port"
  value       = module.postgres01.db_instance_port
}
