terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = ">= 3.0.0"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
}

data "vault_kv_secret_v2" "postgres_password" {
  name  = "postgres"
  mount = "secret"
}
# vault server -dev
# http://127.0.0.1:8200
# $env:VAULT_ADDR="http://127.0.0.1:8200"
# $env:VAULT_TOKEN=""
# vault kv put secret/postgres db_password="pranjal123"

# Examples:

# → Write secrets to kv v1: write <mount>/my-secret foo=bar

# → List kv v1 secret keys: list <mount>/

# → Read a kv v1 secret: read <mount>/my-secret

# → Mount a kv v2 secret engine: write sys/mounts/<mount> type=kv options=version=2

# → Read a kv v2 secret: kv-get <mount>/secret-path

# → Read a kv v2 secret's metadata: kv-get <mount>/secret-path-metadata