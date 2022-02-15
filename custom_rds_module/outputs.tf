output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.postgres01.db_instance_address
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = module.postgres01.db_instance_username
}

output "db_instance_port" {
  description = "The database port"
  value       = module.postgres01.db_instance_port
}
