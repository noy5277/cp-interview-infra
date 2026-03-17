resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
  lower   = false
  numeric = true
}

resource "aws_launch_template" "eks-node-launch-template" {
  name = "${var.cluster_name}-node-launch-template-${random_string.random.result}"

  update_default_version = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # also referred to as Instance Metadata Service Version 2 (IMDSv2)
    http_put_response_hop_limit = 2
  }

  tag_specifications {

    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        "kubernetes.io/cluster/${var.cluster_name}" = "owned"
      }
    )
  }
}


resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = var.cluster_name
  version = var.eks_version
  node_group_name = "${var.cluster_name}-nodegroup-${random_string.random.result}"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.subnets_ids

  instance_types = var.instance_types
  capacity_type = var.capacity_type

  launch_template {
    name    = aws_launch_template.eks-node-launch-template.name
    version = "1"
  }

  update_config {
    max_unavailable = 1
  }

  scaling_config {
    desired_size = var.desired_nodes
    max_size     = var.max_nodes
    min_size     = var.min_nodes
  }

  labels = {
    role = var.label
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [ scaling_config[0].desired_size ]
  }
}