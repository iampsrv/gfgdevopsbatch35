provider "aws" {
  region = "us-east-1"
}

# Use existing VPC (default)
data "aws_vpc" "default" {
  default = true
}

# Use your existing security group by name
data "aws_security_group" "existing" {
  filter {
    name   = "group-name"
    values = ["jenkins"]
  }

  vpc_id = data.aws_vpc.default.id
}

# Use the default DB subnet group (usually created automatically by AWS)
data "aws_db_subnet_group" "default" {
  name = "default"
}

resource "aws_db_instance" "postgres_instance" {
  identifier              = "database-1"
  engine                  = "postgres"
  engine_version          = "15.12"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"

  db_name                 = "database1"  # no hyphen
  username                = "postgres"
  password = data.vault_kv_secret_v2.postgres_password.data["db_password"]
  #password                = var.db_password

  publicly_accessible     = true
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled           = true
  performance_insights_retention_period  = 7

  vpc_security_group_ids  = [data.aws_security_group.existing.id]
  db_subnet_group_name    = data.aws_db_subnet_group.default.name

  tags = {
    Name = "FreeTierPostgres"
  }
}
