provider "aws" {
  region = "us-east-1"
}

module "my_rds_instance" {
  source = "../../"

  rds_instance_name   = "test-rds-mysql"
  engine_version      = var.engine_version
  rds_instance_class  = "db.t3.micro"
  publicly_accessible = var.publicly_accessible
  mz_egress_ips       = var.mz_egress_ips
}

output "rds_instance_endpoint" {
  value     = module.my_rds_instance.rds_instance
  sensitive = true
}

output "vpc" {
  value = module.my_rds_instance.vpc
}

output "mz_rds_mysql_details" {
  value     = module.my_rds_instance.mz_rds_mysql_details
  sensitive = true
}

# TODO: Uncomment the following block to create an SSH bastion server once the module is patched:
# https://github.com/MaterializeInc/terraform-aws-ec2-ssh-bastion/pull/7/files
# module "ec2-ssh-bastion" {
#   source  = "MaterializeInc/ec2-ssh-bastion/aws"
#   version = "0.1.1"

#   mz_egress_ips  = var.mz_egress_ips
#   aws_region     = "us-east-1"
#   vpc_id         = module.my_rds_instance.vpc.vpc_id
#   subnet_id      = module.my_rds_instance.vpc.public_subnets[1]
#   ssh_public_key = var.ssh_public_key
# }

# output "ssh_bastion_details" {
#   value = module.ec2-ssh-bastion.ssh_bastion_details
# }

# output "ssh_bastion_server" {
#   value = module.ec2-ssh-bastion.ssh_bastion_server
# }
