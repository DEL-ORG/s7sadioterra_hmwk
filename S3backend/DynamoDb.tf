
resource "aws_dynamodb_table" "lock" {
  provider       = aws.source
  name           = format("%s-%s-%s-tf-state-lock", var.tags["environment"], var.tags["project"], var.tags["owner"])
  hash_key       = "LockID"
  # read_capacity  = 20
  # write_capacity = 20
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(var.tags,{
  Name           = format("%s-%s-%s-tf-state-lock", var.tags["environment"], var.tags["project"], var.tags["owner"])
  }
  ) 
}
