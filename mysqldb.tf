
  resource "aws_db_instance" "my-global-sql" {
  identifier 		  = "globalscale1"
  instance_class          = "db.t2.micro"
  engine                  = "mysql"
  engine_version          = "5.7"
  multi_az                = true
  storage_type            = "gp2"
  allocated_storage       = 20
  name                    = "myglobalrds"
  username                = "global"
  password                = data.external.rds.result.password 
  backup_retention_period = 10
  vpc_security_group_ids  = [aws_security_group.my-rds-sg1.id]
  skip_final_snapshot     = true
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_window               = "22:00-23:00"
  lifecycle {
      create_before_destroy = true
        }
    }


resource "aws_security_group" "my-rds-sg1" {
  name   = "my-rds-sg1"
  vpc_id = var.vpc_id
  lifecycle {
      create_before_destroy = true
        }
}

resource "aws_security_group_rule" "my-rds-sg1-rule" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.my-rds-sg1.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  lifecycle {
      create_before_destroy = true
        }
}

resource "aws_security_group_rule" "outbound_rule" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.my-rds-sg1.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  lifecycle {
      create_before_destroy = true
        }

}

resource "null_resource" "setup_db" {
  depends_on = [aws_db_instance.my-global-sql] #wait for the db to be ready
  provisioner "local-exec" {
    command = "mysql -u ${aws_db_instance.my-global-sql.username} -p${data.external.rds.result.password} -h ${aws_db_instance.my-global-sql.address} < file.sql"
  }
  lifecycle {
      create_before_destroy = true
        }

}
data "external" "rds" {
  program  = [ "cat", "secrets/rds.json"]

}

