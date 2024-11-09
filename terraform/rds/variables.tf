variable "databases" {
  description = "Map of database configurations"
  type = map(object({
    identifier = string
  }))
}

variable "db_sg_id" {
  description = "Security group ID for databases"
  type        = string
}

variable "subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "db_username" {
  description = "Username for the DBs"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the DBs"
  type        = string
  sensitive   = true
}
