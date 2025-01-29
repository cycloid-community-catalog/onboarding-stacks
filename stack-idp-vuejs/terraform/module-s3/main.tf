resource "aws_s3_bucket" "app" {
  bucket = "${var.cyorg}-${var.cyproject}-${var.cyenv}"
  force_destroy = true

  tags = {
    Name = "${var.cyorg}-${var.cyproject}-${var.cyenv}"
    role = "s3"
  }
}

resource "aws_s3_bucket_website_configuration" "app" {
  bucket = aws_s3_bucket.app.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.app.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "app" {
  bucket = aws_s3_bucket.app.id
  policy = data.aws_iam_policy_document.app.json

  depends_on = [ aws_s3_bucket_public_access_block.app ]
}

data "aws_iam_policy_document" "app" {
  statement {
    sid = "PublicReadGetObject"
    
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.app.arn,
      "${aws_s3_bucket.app.arn}/*",
    ]
  }
}