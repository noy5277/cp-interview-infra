resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : concat(
        [
          {
            "Sid" : "AllowSSLRequestsOnly",
            "Action" : "s3:*",
            "Effect" : "Deny",
            "Resource" : ["${aws_s3_bucket.bucket.arn}", "${aws_s3_bucket.bucket.arn}/*"],
            "Condition" : {
              "Bool" : {
                "aws:SecureTransport" : "false"
              }
            },
            "Principal" : "*"
          }
        ],
        length(var.full_access_principals) == 0 ? [] : [
          {
            "Sid" : "FullAccess"
            "Effect" : "Allow",
            "Action" : [
              "s3:*"
            ],
            "Resource" : ["${aws_s3_bucket.bucket.arn}", "${aws_s3_bucket.bucket.arn}/*"],
            "Principal" : {
              "AWS" : var.full_access_principals
            }
          }
        ],
        var.custom_policy_statements
      )
    }
  )
}