# Manage Auth
path "auth/" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/auth" {
  capabilities = ["read"]
}

path "sys/auth/*" {
  capabilities = ["create", "update", "delete", "sudo"]
}

# Manage ACL Policies
path "sys/policies/acl" {
  capabilities = ["read"]
}

path "sys/policies/acl/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage Secret Engine
path "sys/mounts" {
  capabilities = ["read"]
}

path "sys/mounts/*" {
  capabilities = ["read", "list"]
}

# Read health check
path "sys/health" {
  capabilities = ["read", "sudo"]
}

# Manage transit secret engine
path "transit/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage Secret
path "secret/*" {
  capabilities = {"create", "read", "update", "delete", "list", "sudo"}
}
