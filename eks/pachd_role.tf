
data "aws_iam_policy_document" "s3-access" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::${aws_s3_bucket.pachyderm-s3.id}"]
  }
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = ["arn:aws:s3:::${aws_s3_bucket.pachyderm-s3.id}/*"]
  }
  statement {
    actions = [ "kms:Decrypt",
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:GenerateDataKey*",
        "kms:ReEncrypt*"]
    resources = [aws_kms_key.s3_key.arn]
  }
}

resource "aws_iam_policy" "pachd-s3-access" {
  name   = "pachd-s3-policy"
  policy = data.aws_iam_policy_document.s3-access.json
}

resource "aws_iam_role_policy_attachment" "eks-cluster-s3-attachment" {
  role       = module.eks_cluster.eks_cluster_id
  policy_arn = aws_iam_policy.pachd-s3-access.arn
  depends_on = [module.eks_node_group]
}

resource "aws_iam_role_policy_attachment" "eks-node-s3-attachment" {
  role       = module.eks_node_group.eks_node_group_role_name
  policy_arn = aws_iam_policy.pachd-s3-access.arn
  depends_on = [module.eks_cluster]
}