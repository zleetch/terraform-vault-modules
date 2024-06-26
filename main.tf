resource "vault_mount" "secret_engine" {
  for_each    = var.secret_engine
  path        = each.value.path
  type        = each.value.type
  description = each.value.description
}
