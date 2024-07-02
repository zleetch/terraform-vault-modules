resource "vault_mount" "secret_engine" {
  for_each                  = var.secret_engine
  path                      = each.value.path
  type                      = each.value.type
  description               = each.value.description
  default_lease_ttl_seconds = try(each.value.default_lease_ttl_seconds, null)
  max_lease_ttl_seconds     = try(each.value.max_lease_ttl_seconds, null)
  options                   = try(each.value.options, null)
}

resource "vault_policy" "policies" {
  for_each = var.policies
  name     = each.value.name
  policy   = file("policies/${each.value.name}-policy.hcl")
}

resource "vault_database_secret_backend_connection" "connections" {
  for_each                 = var.databases
  backend                  = vault_mount.secret_engine[each.value.backend].path
  name                     = each.value.name
  namespace                = try(each.value.namespace, null)
  plugin_name              = try(each.value.plugin_name, null)
  verify_connection        = try(each.value.verify_connection, null)
  allowed_roles            = try(each.value.allowed_roles, null)
  root_rotation_statements = try(each.value.root_rotation_statements, null)
  dynamic "postgresql" {
    for_each = each.value.postgresql
    content {
      connection_url          = postgresql.connection_url
      max_open_connections    = try(postgresql.max_open_connections, null)
      max_idle_connections    = try(postgresql.max_idle_connections, null)
      max_connection_lifetime = try(postgresql.max_connection_lifetime, null)
      username                = try(postgresql.username, null)
      password                = try(postgresql.password, null)
      auth_type               = try(postgresql.auth_type, null)
      service_account_json    = try(postgresql.service_account_json, null)
      disable_escaping        = try(postgresql.disable_escaping, null)
      username_template       = try(postgresql.username_template, null)
    }
  }
  dynamic "cassandra" {
    for_each = each.value.cassandra
    content {
      hosts            = cassandra.host
      username         = cassandra.username
      password         = cassandra.password
      port             = try(cassandra.port, null)
      tls              = try(cassandra.tls, null)
      insecure_tls     = try(cassandra.insecure_tls, null)
      pem_bundle       = try(cassandra.pem_bundle, null)
      pem_json         = try(cassandra.pem_json, null)
      protocol_version = try(cassandra.protocol_version, null)
      connect_timeout  = try(cassandra.connect_timeout, null)
    }
  }
  dynamic "redis" {
    for_each = each.value.redis
    content {
      host         = redis.host
      username     = redis.username
      password     = redis.password
      port         = redis.port
      tls          = try(redis.tls, null)
      insecure_tls = try(redis.insecure_tls, null)
      ca_cert      = try(redis.ca_cert, null)
    }
  }
  dynamic "redis_elasticache" {
    for_each = each.value.elasticache
    content {
      url      = elasticache.url
      username = try(elasticache.username, null)
      password = try(elasticache.password, null)
      region   = try(elasticache.region, null)
    }
  }
  dynamic "mongodb" {
    for_each = each.value.mongo
    content {
      connection_url    = mongodb.url
      username          = mongodb.username
      password          = mongodb.password
      username_template = try(mongodb.username_template, null)
    }
  }
  dynamic "mssql" {
    for_each = each.value.mssql
    content {
      connection_url          = mssql.url
      max_open_connections    = try(mssql.max_open_connections, null)
      max_idle_connections    = try(mssql.max_idle_connections, null)
      max_connection_lifetime = try(mssql.max_connection_lifetime, null)
      username_template       = try(mssql.username_template, null)
      username                = try(mssql.username, null)
      password                = try(mssql.password, null)
      disable_escaping        = try(mssql.disable_escaping, null)
      contained_db            = try(mssql.contained_db, null)
    }
  }
  dynamic "mysql" {
    for_each = each.value.mysql
    content {
      connection_url          = mysql.url
      max_open_connections    = try(mysql.max_open_connections, null)
      max_idle_connections    = try(mysql.max_idle_connections, null)
      max_connection_lifetime = try(mysql.max_connection_lifetime, null)
      username                = try(mysql.username, null)
      password                = try(mysql.password, null)
      auth_type               = try(mysql.auth_type, null)
      service_account_json    = try(mysql.service_account_json, null)
      tls_certificate_key     = try(mysql.tls_certificate_key, null)
      tls_ca                  = try(mysql.tls_ca, null)
      username_template       = try(mysql.username_template, null)
    }
  }
}

resource "vault_database_secret_backend_role" "roles" {
  for_each              = var.database_roles
  backend               = vault_mount.secret_engine[each.value.backend].path
  name                  = each.value.name
  db_name               = vault_database_secret_backend_connection.connections[each.value.db_name].name
  creation_statements   = each.value.creation_statements
  revocation_statements = try(each.value.revocation_statements, null)
  rollback_statements   = try(each.value.rollback_statements, null)
  renew_statements      = try(each.value.renew_statements, null)
  default_ttl           = try(each.value.default_ttl, null)
  max_ttl               = try(each.value.max_ttl, null)
  credential_type       = try(each.value.credential_type, null)
  credential_config     = try(each.value.credential_config, null)
}

resource "vault_database_secret_backend_static_role" "roles" {
  for_each = var.database_static_roles
  backend  = vault_mount.secret_engine[each.value.backend].path
  name     = each.value.name
  db_name  = vault_database_secret_backend_connection.connections[each.value.db_name].name
  username = each.value.username
}
