# RDS PostgreSQL
resource "aws_db_instance" "cbddb01" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17.6"
  instance_class       = "db.t4g.micro"
  db_name              = "cbddb01"
  username             = "pgadminuser"
  password             = "pgadminuser123!"
  parameter_group_name = "default.postgres17"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.CB-np.id]
  db_subnet_group_name   = aws_db_subnet_group.private-a-np.name

tags = merge(
        var.common_tags,
                {
                Name = "cbddb01"
                Environment = "dev"
                SID = "CBD"
                }
        )
}

# Subnet group for RDS np
resource "aws_db_subnet_group" "private-a-np" {
  name       = "postgres-subnet-group-private-a"
  subnet_ids = [aws_subnet.private-a-np.id, aws_subnet.private-b-np.id]
}