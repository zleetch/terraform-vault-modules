output "secret_engine_path" {
  description = "The path of the enabled secrets engine"
  value = {
    for k, v in vault_mount.secret_engine : k => v.path
  }
}

output "secret_engine_type" {
  description = "The type of the enabled secrets engine"
  value = {
    for k, v in vault_mount.secret_engine : k => v.type
  }
}
