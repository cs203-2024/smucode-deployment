output "db_endpoints" {
  description = "Map of database endpoints"
  value = {
    for name, instance in aws_db_instance.db : name => instance.endpoint
  }
  sensitive = true
}

output "db_addresses" {
  description = "Map of database addresses"
  value = {
    for name, instance in aws_db_instance.db : name => instance.address
  }
  sensitive = true
}
