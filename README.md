# terraform-vault-engine
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_database_secret_backend_connection.connections](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_connection) | resource |
| [vault_database_secret_backend_role.role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_role) | resource |
| [vault_mount.secret_engine](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.policies](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_roles"></a> [database\_roles](#input\_database\_roles) | All Database Roles | `any` | `null` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | All Databases | `any` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | All Policies | `any` | `null` | no |
| <a name="input_secret_engine"></a> [secret\_engine](#input\_secret\_engine) | Secret Engine | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_connection"></a> [database\_connection](#output\_database\_connection) | All database connection |
| <a name="output_secret_engine_path"></a> [secret\_engine\_path](#output\_secret\_engine\_path) | The path of the enabled secrets engine |
| <a name="output_secret_engine_type"></a> [secret\_engine\_type](#output\_secret\_engine\_type) | The type of the enabled secrets engine |
<!-- END_TF_DOCS -->