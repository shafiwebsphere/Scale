resource "aws_launch_configuration" "my-global-launch-config" {
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.global.id]
  key_name = var.key_name
  iam_instance_profile = aws_iam_instance_profile.global_profile.name
  user_data = file("execute_db.sh")
  depends_on = [aws_db_instance.my-global-sql]
  lifecycle {
      create_before_destroy = true
           }
}

resource "aws_autoscaling_group" "global" {
  launch_configuration = aws_launch_configuration.my-global-launch-config.name
  vpc_zone_identifier  = [var.subnet1,var.subnet2]
  health_check_type    = "ELB"

  min_size = 1
  max_size = 1

  tag {
    key                 = "Name"
    value               = "my-global-asg"
    propagate_at_launch = true

  }
lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "global" {
  name   = "global"
  vpc_id = var.vpc_id
lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "inbound_ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.global.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]  
  lifecycle {
      create_before_destroy = true
           }

}

resource "aws_security_group_rule" "inbound_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.global.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  lifecycle {
      create_before_destroy = true
           }

}

resource "aws_security_group_rule" "outbound_all" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.global.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  lifecycle {
      create_before_destroy = true
           }

}

