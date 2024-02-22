provider "aws" {
  region = "us-east-1"
}

module "my_rds_instance" {
  source = "../../"

  rds_instance_name     = "test-rds-mysql"
  engine_version        = "8.0.36"
  rds_instance_class    = "db.t3.micro"
  publicly_accessible   = true
  mz_egress_ips         = var.mz_egress_ips
}

output "rds_instance_endpoint" {
  value = module.my_rds_instance.rds_instance
  sensitive = true
}

output "mz_rds_mysql_details" {
  value = module.my_rds_instance.mz_rds_mysql_details
  sensitive = true
}
