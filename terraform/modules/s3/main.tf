resource "aws_s3_bucket" "todo_backup" {

  bucket = var.bucket_name

  tags = {
    Name        = "ToDo Backup Bucket"
    Project     = "Flask ToDo App"
    Environment = "Dev"
  }

}
resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.todo_backup.id

  versioning_configuration {

    status = "Enabled"

  }

}
resource "aws_s3_bucket_public_access_block" "public_access" {

  bucket = aws_s3_bucket.todo_backup.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true

}