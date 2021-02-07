resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "s3-role"
  assume_role_policy = file("rolepolicy.json")
  lifecycle {
      create_before_destroy = true
        }

}
resource "aws_iam_policy" "policy" {
  name        = "global-policy"
  description = "A global policy"
  policy      = file("policys3bucket.json")
  lifecycle {
      create_before_destroy = true
        }

}

resource "aws_iam_policy_attachment" "global-attach" {
  name       = "global-attachment"
  roles      = [aws_iam_role.ec2_s3_access_role.name]
  policy_arn = aws_iam_policy.policy.arn
  lifecycle {
      create_before_destroy = true
        }

}

resource "aws_iam_instance_profile" "global_profile" {
  name  = "global_profile"
  role = aws_iam_role.ec2_s3_access_role.name
  lifecycle {
      create_before_destroy = true
        }

}
