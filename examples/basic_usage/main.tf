provider "aws" {
  region = "us-west-1"
}

module "my_rds_instance" {
  source = "../../"

  rds_instance_name     = "test-rds-instance"
  engine_version        = "8.0.23"
  rds_instance_class    = "db.t3.micro"
  publicly_accessible   = true
  mz_egress_ips         = var.mz_egress_ips
}

output "rds_instance_endpoint" {
  value = module.my_rds_instance.rds_instance_endpoint
}
