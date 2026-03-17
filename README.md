# EKS Infrastructure – Terraform Deployment

This repository contains Terraform configurations to deploy a complete Amazon EKS (Elastic Kubernetes Service) environment.  
It includes the following components:

- VPC  
- Subnets  
- Internet Gateway & Routing  
- EKS Cluster  
- EKS Managed Node Groups  
- EKS Addons  
- AWS Load Balancer Controller (LBC)  
- ECR Repository  

All infrastructure is organized into reusable, modular Terraform components.

---

##  Modules Overview

### **VPC Module (`./modules/vpc`)**
Creates the main Virtual Private Cloud with DNS support and DNS hostnames enabled.

### **Subnet Module (`./modules/subnet`)**
Creates public or private subnets based on input variables.  
Subnets are tagged for Kubernetes and ELB compatibility.

### **EKS Cluster Module (`./modules/eks`)**
Creates the control plane, configures API endpoint access, adds cluster tags, and sets the Kubernetes version.

### **Node Group Module (`./modules/eks-node-group`)**
Creates managed node groups defined in `var.node_groups` including:
- Instance types  
- Desired, min, and max capacity  
- Capacity type (spot/on-demand)

### **Addons Module (`./modules/addons`)**
Installs EKS addons

### **Load Balancer Controller (`./modules/lbc`)**
Deploys AWS Load Balancer Controller (ALB/ELB ingress support).

### **ECR Module (`./modules/ecr`)**
Creates an AWS ECR repository for storing Docker container images.

---

## Usage Guide ##
1. Configure the Terraform Backend
Create a file named backend.tf to define the remote backend for storing the Terraform state file:

# backend.tf
```
terraform {
  backend "s3" {
    bucket       = "hello-world-crossplane-demo"
    key          = "terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}

```

---
2. Create the Terraform Variables File
Create a file named terraform.tfvars (or use terraform.tfvars.template as a base).
Populate it with the required configuration values:

# terrform.tfvars #
```
#terrform.tfvars.template
aws_region      = "us-east-2"
s3-backend-name = "hello-world-crossplane-demo"
tags            = {}

#########################################  vpc ####################################

vpc_name             = "hello-world-stage-vpc"
vpc_cidr_block       = "20.0.0.0/16"
enable_dns_support   = true
enable_dns_hostnames = true

#########################################  subnets ####################################

subnets = {
  stage-public-a = {
    cidr_block        = "20.0.0.0/24"
    availability_zone = "a"
    type              = "public"
  },
  stage-public-b = {
    cidr_block        = "20.0.1.0/24"
    availability_zone = "b"
    type              = "public"
  }
}

#########################################  eks ###################################
eks_name                     = "hello-world"
env                          = "stage"
eks_version                  = "1.31"
kubernetes_resources_ip_cidr = "172.16.0.0/16"
endpoint_public_access       = true
endpoint_private_access      = true

node_groups = {
  general = {
    label              = "general"
    subnets_ids        = ["subnet-027a07f98a890454b", "subnet-016a01cec4dc0efc0"]
    security_group_ids = ["sg-0fd2420db3642b26b"]
    instance_types     = ["t3.large", "t3a.large"]
    capacity_type      = "ON_DEMAND"
    min_nodes          = 2
    max_nodes          = 4
    desired_nodes      = 2
  }
}

addons = ["coredns","vpc-cni","kube-proxy"]

#########################################  ecr ###################################
ecr_repository_name = "hello-world"
```

---
3. Apply the Terraform Configuration
Run the following commands from your Terraform working directory:
```
terraform init
terraform plan -var-file terrform.tfvars
terraform apply -var-file terrform.tfvars
```

4. Expected Terraform Outputs
After applying the configuration, Terraform will display the following outputs (values shown as an example):

```
Changes to Outputs:
  + cluster_name       = "stage-hello-world"
  + cluster_public_url = "https://26266F4CCC9802442E568EB2E3B0FC30.gr7.us-east-2.eks.amazonaws.com"
  + region             = "us-east-2"
```

## Contributors: ##
noy5277@gmail.com