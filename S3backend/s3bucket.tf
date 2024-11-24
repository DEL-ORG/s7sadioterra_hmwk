resource "aws_s3_bucket" "bucket" {
  provider       = aws.source
  force_destroy  = var.force_destroy
  bucket         = format("%s-%s-%s-tf-state", var.tags["environment"], var.tags["project"], var.tags["owner"])
  tags           = var.tags
}

resource "aws_s3_bucket" "backup" {
  provider       = aws.target
  force_destroy  = var.force_destroy
  bucket         = format("%s-%s-%s-tf-backup", var.tags["environment"], var.tags["project"], var.tags["owner"])
  tags           = var.tags
}

resource "aws_s3_bucket_versioning" "state_versioning" {
  provider = aws.source
  depends_on = [aws_s3_bucket.bucket]
  bucket     = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "backup_versioning" {
  provider = aws.target
  depends_on = [aws_s3_bucket.backup]
  bucket     = aws_s3_bucket.backup.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  depends_on = [
    aws_s3_bucket.bucket,
    aws_s3_bucket.backup
  ]
  bucket = aws_s3_bucket.bucket.id
  role   = aws_iam_role.terra_bucket.arn

  rule {
    id     = "StateReplicationAll"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.backup.arn
      storage_class = "STANDARD"
}
}
}