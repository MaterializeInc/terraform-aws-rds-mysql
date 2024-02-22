# Basic Usage Example for RDS Module

This example demonstrates how to use the RDS module to create a MySQL RDS instance.

## Usage

To run this example, you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

> Note: Ensure you replace placeholder values in terraform.tfvars with real values suited to your environment.

## Resources Created

- An AWS VPC configured for the RDS instance.
- An RDS instance with MySQL configured for GTID-based replication.

## Destroy

To destroy the resources created, run:

```bash
terraform destroy
```
