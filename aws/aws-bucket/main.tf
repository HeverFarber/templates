provider "aws" {
  region = "us-east-1"
}

# 1. S3 Bucket with 30-day TTL (Lifecycle Rule)
resource "aws_s3_bucket" "data_bucket" {
  bucket = "my-app-env0-data-bucket-unique-name"

  lifecycle_rule {
    id      = "log"
    enabled = true

    expiration {
      days = 90
    }

    noncurrent_version_expiration {
      days = 12
    }

    abort_incomplete_multipart_upload_days = 10
  }

  tags = {
    Name        = "My App Data Bucket"
    Environment = "Development"
    TTL         = "30 days"
    SLA         = "high"
  }
}

# 2. IAM User
resource "aws_iam_user" "s3_reader_user" {
  name = "s3-readonly-user-example"
  path = "/system/"

  tags = {
    Description = "IAM user with read-only access to a specific S3 bucket And RDS"
  }
}

resource "aws_iam_policy" "s3_read_only_policy" {
  name        = "S3ReadOnlyAccessPolicy-my-app-env0-data-bucket-unique-name"
  path        = "/"
  description = "Policy to grant read-only access to my-app-env0-data-bucket-unique-name"

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
          "arn:aws:s3:::my-app-env0-data-bucket-unique-name"
        ]
      },
      {
        Sid    = "AllowGetObject",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::my-app-env0-data-bucket-unique-name/*"
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
