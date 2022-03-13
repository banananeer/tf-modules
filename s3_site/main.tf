module "bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  attach_policy = true
  policy        = data.aws_iam_policy_document.bucket_policy.json

  acl    = "public-read"

  versioning = var.versioning

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AllowPublicGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.bucket.s3_bucket_arn}/*"
    ]
  }
}