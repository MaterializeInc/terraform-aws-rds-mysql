# The Materialize egress IPs, eg: SELECT * FROM mz_egress_ips;
variable "mz_egress_ips" {
  description = "List of Materialize egress IPs"
  type        = list(any)
}

# RDS MySQL engine version
variable "engine_version" {
  description = "The engine version of the MySQL RDS instance"
  type        = string
  default     = "8.0.36" # Tested with both 5.7.44 and 8.0.36
}
