// IAM User creation to be added
// Testing S3 bucket creation

provider "aws" {
  region = var.aws_region
}

// S3 public bucket with versioning enabled

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket_prefix = var.bucket_prefix
  acl = var.acl
  
   versioning {
    enabled = var.versioning
  }
  
  tags = var.tags
}


// Creating a IAM User with Access and Secret Key - stored to AWS Parameters

# The user to which we will grant access to s3
resource "aws_iam_user" "user" {
  name          = "s3-user"
  // path          = "/"
}

# Create the access key
resource "aws_iam_access_key" "key_pair" {
  user = aws_iam_user.user.name
}

# Store Access Key and Secret Key in AWS SSM
resource "aws_ssm_parameter" "iam_user_aws_access_key" {
  name        = "iam-user-accesskey"
  description = "Access key for IAM User"
  type        = "SecureString"
  value       = aws_iam_access_key.key_pair.id

}

resource "aws_ssm_parameter" "iam_user_aws_secret_key" {
  name        = "iam-user-secretkey"
  description = "Secret Key for IAM User"
  type        = "SecureString"
  value       = aws_iam_access_key.key_pair.secret
}


// Creating a IAM Policy for IAM User

data "aws_iam_policy_document" "s3_role_access_policy" {

  statement {
    sid = "ApplicationObjectAccess"

    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.my_s3_bucket.arn,
      "${aws_s3_bucket.my_s3_bucket.arn}/*",
    ]
  }
}

// Assuming role for IAM user for S3 bucket actions

resource "aws_iam_role" "s3_role_assume" {

  name        = "s3-bucket-assume-role"
  description = "Role for s3 bucket"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        "AWS" : aws_iam_user.user.arn
      },
      Condition : {}
    }],
    Version = "2012-10-17"
  })

}

// Policy attachement

resource "aws_iam_policy" "s3_iam_policy" {
  name   = "s3_iam_policy"
  policy = data.aws_iam_policy_document.s3_role_access_policy.json
}

resource "aws_iam_role_policy_attachment" "s3_role_policy_attachment" {
  role       = aws_iam_role.s3_role_assume.name
  policy_arn = aws_iam_policy.s3_iam_policy.arn
}