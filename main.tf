resource "vault_mount" "secret_engine" {
  for_each    = var.secret_engine
  path        = each.value.path
  type        = each.value.type
  description = each.value.description
}

resource "vault_policy" "policies" {
  for_each = var.policies
  name     = each.value.name
  policy   = file("policies/${each.value.name}-policy.hcl")
}
