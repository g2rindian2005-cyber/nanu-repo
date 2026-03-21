resource "aws_s3_bucket" "name" {
      bucket = var.bucket_name
  tags = {
    Name =  var.bucket_name
    Envirement = var.environment
  }

}# Enable versioning (recommended)


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.name.id

  versioning_configuration {
    status = "Enabled"
  }
}