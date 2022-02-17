# cloudsql-to-rds
cd custom_rds_module

set variables in ./local.tf and ./backend.tf

export TF_VAR_username="xxxx"

export TF_VAR_password="xxxx"

samlaz

terraform init

terraform plan

terraform apply

ssh -f -l ubuntu -L 5432:[rds endpoint]:5432 [bastion] -v

psql -hlocalhost -Upostgres -p5432 -d postgres

disable termination protection in console

terraform destroy

remove final snapshot & automatic snapshot in console