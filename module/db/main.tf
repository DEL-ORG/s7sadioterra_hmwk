provider "aws" {
  region = "us-east-1"
}

# Security Group for PostgreSQL
resource "aws_security_group" "db_security_group" {
  name        = "postgres-security-group"
  description = "Allow inbound traffic for PostgreSQL"
  #vpc_id      = "vpc-xxxxxxxx" # Replace with your VPC ID

  # Ingress rules (allow inbound traffic)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all IPs for dev/test; update for production.
  }

  # Egress rules (allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    environment = "dev"
    project     = "demo"
    owner       = "first-lady"
    name        = "db_security_group"
  }
}

# RDS Parameter Group
resource "aws_db_parameter_group" "postgres_params" {
  name        = "postgres-params"
  family      = "postgres16"
  description = "Custom parameter group for PostgreSQL"
   
  tags = {
    environment = "dev"
    project     = "demo"
    owner       = "first-lady"
    name        = "postgres-params"
  }
}

# Create a PostgreSQL RDS instance
resource "aws_db_instance" "postgres" {
  identifier                = "my-postgres-db"
   db_name                   = "mydb"
  engine                    = "postgres"
  engine_version            = "16.3"
  instance_class            = "db.t3.micro"
  allocated_storage         = 20
  #max_allocated_storage     = 100 # Enable storage autoscaling
  username                  = "developer"
  password                  = "securepassword123" # Replace with a strong password
  publicly_accessible       = true # Public for dev/test
  skip_final_snapshot       = true
   storage_type              = "gp2"
    # VPC and Security Group
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  # Attach Parameter Group
  parameter_group_name = aws_db_parameter_group.postgres_params.name
  tags = {
    environment = "dev"
    project     = "demo"
    owner       = "first-lady"
    name        = "my-postgres-db"
  }
#    parameters {
      
#     name  = "postgres_params"
#     value = "1"
#   }
}
 #deletion_protection       = false # Disable for dev/test
#   backup_retention_period   = 7 # Retain backups for 7 days
#   multi_az                  = false # Single AZ for dev/test
 # auto_minor_version_upgrade = true # Automatically apply minor updates
#   # Enable Performance Insights
#   performance_insights_enabled = true
#   performance_insights_retention_period = 7 # Retain for 7 days
# # Output the RDS endpoint and credentials
# output "rds_endpoint" {
#   value = aws_db_instance.postgres.endpoint
# }
# output "rds_username" {
#   value = aws_db_instance.postgres.username
# }
# output "rds_db_name" {
#   value = aws_db_instance.postgres.name
# }
