<!-- BEGIN_TF_DOCS -->
# Materialize + MySQL RDS + Terraform

Terraform module for deploying a new RDS MySQL instance and connecting it to Materialize.

For the manual setup, see the [Materialize + RDS](TODO) documentation.

> **Warning** This is provided on a best-effort basis and Materialize cannot offer support for this module.

The module has been tested with MySQL `8.0.36` and MySQL `5.7.44`.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.5.2 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.mz_rds_demo_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.mz_rds_demo_mysql_pg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.mz_rds_demo_db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.mz_rds_demo_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_string.mz_rds_demo_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [http_http.user_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"us-west-1"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version of the MySQL RDS instance | `string` | `"8.0.36"` | no |
| <a name="input_mz_egress_ips"></a> [mz\_egress\_ips](#input\_mz\_egress\_ips) | List of Materialize egress IPs | `list(any)` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Whether the RDS instance is publicly accessible or not | `bool` | `true` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The size of the RDS instance | `string` | `"db.m5.large"` | no |
| <a name="input_rds_instance_name"></a> [rds\_instance\_name](#input\_rds\_instance\_name) | The name of the RDS instance | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mz_rds_mysql_details"></a> [mz\_rds\_mysql\_details](#output\_mz\_rds\_mysql\_details) | n/a |
| <a name="output_rds_instance"></a> [rds\_instance](#output\_rds\_instance) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |
<!-- END_TF_DOCS -->
