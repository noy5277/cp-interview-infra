# data "aws_caller_identity" "current" {}

# # Example: allow an external role to pull/push
# resource "aws_ecr_repository_policy" "this" {
#   repository = aws_ecr_repository.this.name
#   policy     = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid      = "AllowPullPushFromRole",
#         Effect   = "Allow",
#         Action = [
#           "ecr:BatchCheckLayerAvailability",
#           "ecr:BatchGetImage",
#           "ecr:CompleteLayerUpload",
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:GetRepositoryPolicy",
#           "ecr:InitiateLayerUpload",
#           "ecr:ListImages",
#           "ecr:PutImage",
#           "ecr:UploadLayerPart",
#           "ecr:DescribeImages"
#         ]
#       }
#     ]
#   })
# }