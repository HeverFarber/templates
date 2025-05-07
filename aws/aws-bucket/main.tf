provider "aws" {
  region = "us-east-1"
}

# 1. S3 Bucket with 30-day TTL (Lifecycle Rule)
resource "aws_s3_bucket" "data_bucket" {
  bucket = "my-app-env0-data-bucket-unique-name" # Choose a globally unique bucket name

  lifecycle_rule {
    id      = "log"
    enabled = true

    expiration {
      days = 30
    }

    # You can also add prefixes if you only want the rule to apply to certain objects
    # prefix = "logs/"

    # It's good practice to also manage incomplete multipart uploads
    abort_incomplete_multipart_upload_days = 7
  }

  tags = {
    Name        = "My App Data Bucket"
    Environment = "Development"
    TTL         = "30 days"
  }
}

# 2. IAM User
resource "aws_iam_user" "s3_reader_user" {
  name = "s3-readonly-user-example"
  path = "/system/"

  tags = {
    Description = "IAM user with read-only access to a specific S3 bucket"
  }
}

resource "aws_iam_policy" "s3_read_only_policy" {
  name        = "S3ReadOnlyAccessPolicy-${aws_s3_bucket.data_bucket.id}"
  path        = "/"
  description = "Policy to grant read-only access to ${aws_s3_bucket.data_bucket.id}"

  # Define the policy directly as a JSON string
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowListBucket",
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.data_bucket.arn
        ]
      },
      {
        Sid    = "AllowGetObject",
        Effect = "Allow",
        Action = [
          "s3:GetObject"
        ],
        Resource = [
          "${aws_s3_bucket.data_bucket.arn}/*" # Note the /* for objects within the bucket
        ]
      }
    ]
  })
}

# 4. Attach Policy to User
resource "aws_iam_policy_attachment" "s3_reader_attachment" {
  name       = "s3-reader-policy-attachment"
  users      = [aws_iam_user.s3_reader_user.name]
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
}
