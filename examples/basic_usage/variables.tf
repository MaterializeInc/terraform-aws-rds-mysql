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

# RDS publicly_accessible
variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible or not"
  type        = bool
  default     = true
}

# SSH public key for the bastion server
variable "ssh_public_key" {
  description = "SSH public key for the bastion server"
  type        = string
}
