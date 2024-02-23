module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  name                 = "${var.rds_instance_name}-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.6.0/24", "10.0.7.0/24"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "mz_rds_demo_db_subnet_group" {
  name       = "${var.rds_instance_name}-db-subnet-group"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "mz_rds_demo_db_subnet_group"
  }
}

resource "aws_security_group" "mz_rds_demo_sg" {
  name        = "${var.rds_instance_name}-sg"
  description = "Materialize RDS Terraform demo"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = distinct(concat(var.mz_egress_ips, [format("%s/%s", data.http.user_public_ip.response_body, "32")]))
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_string" "mz_rds_demo_db_password" {
  length  = 32
  upper   = true
  numeric = true
  special = false
}

resource "aws_db_parameter_group" "mz_rds_demo_mysql_pg" {
  name = "${var.rds_instance_name}-mysql"

  # If the engine version is 5.7, use the family "mysql5.7" else use "mysql8.0"
  family = substr(var.engine_version, 0, 3) == "5.7" ? "mysql5.7" : "mysql8.0"

  # Note: `replica_preserve_commit_order` is not directly exposed as a parameter for RDS.

  parameter {
    # Static parameter
    name         = "enforce_gtid_consistency"
    value        = "ON"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "binlog_format"
    value        = "ROW"
    apply_method = "immediate"
  }

  parameter {
    name         = "binlog_row_image"
    value        = "FULL"
    apply_method = "immediate"
  }

  parameter {
    name         = "gtid-mode"
    value        = "ON"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_instance" "mz_rds_demo_db" {
  identifier             = var.rds_instance_name
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = var.engine_version
  instance_class         = var.rds_instance_class
  db_name                = "materialize"
  username               = "materialize"
  password               = random_string.mz_rds_demo_db_password.result
  vpc_security_group_ids = [aws_security_group.mz_rds_demo_sg.id]
  parameter_group_name   = aws_db_parameter_group.mz_rds_demo_mysql_pg.name
  apply_immediately      = true
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.mz_rds_demo_db_subnet_group.name
  # Enable automatic backups as it feature determines whether binary logging is turned on or off for MySQL.
  backup_retention_period = 1
}
