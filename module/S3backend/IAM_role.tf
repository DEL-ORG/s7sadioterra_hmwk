resource "aws_iam_role" "terra_bucket" {
 
  name     = format("%s-%s-%s-s3-replication-role", var.tags["environment"], var.tags["project"], var.tags["owner"])

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
  tags               = var.tags
}

resource "aws_iam_policy" "terra_bucket_rep" {
 
  name     = format("%s-%s-%s-s3-replication-policy", var.tags["environment"], var.tags["project"], var.tags["owner"])

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.backup.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "terra_bucket_rep" {
  provider   = aws.source
  name       = format("%s-%s-%s-s3-replication-policy-attachment", var.tags["environment"], var.tags["project"], var.tags["owner"])
  roles     = [aws_iam_role.terra_bucket.name]
  policy_arn = aws_iam_policy.terra_bucket_rep.arn
}