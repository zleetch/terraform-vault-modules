output "secret_engine_path" {
  description = "The path of the enabled secrets engine"
  value = [
    for v in vault_mount.secret_engine.v : v.path
  ]
}

output "secret_engine_type" {
  description = "The type of the enabled secrets engine"
  value = [
    for v in vault_mount.secret_engine.v : v.type
  ]
}
