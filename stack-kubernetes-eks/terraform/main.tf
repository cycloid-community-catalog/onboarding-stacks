################################################################################
# EKS Module https://github.com/terraform-aws-modules/terraform-aws-eks
################################################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31.6"

  cluster_name    = "${var.project}-${var.env}"
  cluster_version = "1.29"

  # extra addons required
  cluster_addons = {
    # DNS server that can serve as the Kubernetes cluster DNS
    # more info https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html
    coredns = {}
    # kube-proxy maintains network rules on nodes
    # more info https://docs.aws.amazon.com/eks/latest/userguide/managing-kube-proxy.html
    kube-proxy = {}

    # allows pods to have the same IP address inside the pod as they do on the VPC network
    # more info https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html
    # If needed to update manually: https://docs.aws.amazon.com/en_us/eks/latest/userguide/managing-vpc-cni.html
    vpc-cni = {
      configuration_values = local.vpc_cni_config
    }
  }

  # Configuration of nodes

  # EKS Managed Node Group(s)
  # default node group to add more add: eks_managed_node_groups group
  # all available options to configure cluster here https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/node_groups.tf#L230
  eks_managed_node_group_defaults = {
    # ami_type       = "AL2_x86_64"
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
    capacity_type  = "ON_DEMAND"
    key_name       = var.keypair_name

    # can't use disk_size because the module by default use a custom template and this param is not compatible
    # disk_size      = var.node_disk_size
    # we have to define the block_device_mappings
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size           = var.node_disk_size
          volume_type           = "gp3"
          iops                  = 3000
          throughput            = 150
          delete_on_termination = true
        }
      }
    }

    # We are using the IRSA created below for permissions
    # However, we have to deploy with the policy attached FIRST (when creating a fresh cluster)
    # and then turn this off after the cluster/node group is created. Without this initial policy,
    # the VPC CNI fails to assign IPs and nodes cannot join the cluster
    # See https://github.com/aws/containers-roadmap/issues/1666 for more context
    iam_role_attach_cni_policy = true

    # https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
    # The current bootstrap.sh script don't take care about prefix delegation. So we need to set ourself the max-pod
    # Recommendation: less than 30 vCPUs the maximum number is 110 else 250
    # https://github.com/awslabs/amazon-eks-ami/blob/master/files/bootstrap.sh
    pre_bootstrap_user_data = <<-EOT
    #!/bin/bash
    set -ex
    cat <<-EOF > /etc/profile.d/bootstrap.sh
    # export CONTAINER_RUNTIME="containerd" # default since 1.24
    export USE_MAX_PODS=false
    export KUBELET_EXTRA_ARGS="--max-pods=110"
    EOF
    # Source extra environment variables in bootstrap script
    sed -i '/^set -o errexit/a\\nsource /etc/profile.d/bootstrap.sh' /etc/eks/bootstrap.sh
    sed -i 's/KUBELET_EXTRA_ARGS=$2/KUBELET_EXTRA_ARGS="$2 $KUBELET_EXTRA_ARGS"/' /etc/eks/bootstrap.sh
    EOT

  }

  eks_managed_node_groups = {
    "k8s-${var.env}-green" = {
      min_size       = 1
      max_size       = var.node_max_size
      desired_size   = var.node_desired_size
      instance_types = [var.node_instance_type]
    }
  }

  cluster_tags = {
    Name = "${var.project}-${var.env}"
  }

  # configure access to cluster

  # enable private and public access to cluster
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # Enable authentification by API and configmap.
  # ConfigMap is used to map IAM role to cluster role
  # https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
  # aws-auth config map has been move to a dedicated module (and might be removed later)
  # https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master/modules/aws-auth
  authentication_mode = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  # networking
  vpc_id     = module.vpc.vpc_id
  subnet_ids = local.subnet_ids_needed
  # by default controller use same subnet_ids as node.
  # for it to not have changes that makes cluster recreate (https://github.com/hashicorp/terraform-provider-kubernetes/issues/1028)
  control_plane_subnet_ids = module.vpc.private_subnets

  # By default controler doesn't have full output access, we need to extend the default security rule groups,
  # to allow worker Kubelets and pods to receive communication from the cluster control plane
  # more information here: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/network_connectivity.md#security-groups
  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
     description = "Node to node all ports/protocols"
     protocol    = "-1"
     from_port   = 0
     to_port     = 0
     type        = "ingress"
     self        = true
    }

    # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/node_groups.tf#L130
    # now by default 8443 "Validating Admission Webhook"
    # now by default 9443 "Allow access from control plane to webhook port of AWS load balancer controller"
    # now by default 10250 "Cluster API to metrics server 10250 port"
    # now allowed by default egress 0.0.0.0/0 "Node all egress"

  }
}


################################################################################
# VPC Module https://github.com/terraform-aws-modules/terraform-aws-vpc
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.17.0"

  name = "${var.project}-${var.env}"

  # TODO:  # use local map var such as env == staging => var.subnet_ip_digit = 0 ???
  cidr                = "10.${var.subnet_ip_digit}.0.0/16"
  private_subnets     = ["10.${var.subnet_ip_digit}.0.0/19", "10.${var.subnet_ip_digit}.32.0/19", "10.${var.subnet_ip_digit}.64.0/19"]
  public_subnets      = ["10.${var.subnet_ip_digit}.96.0/19", "10.${var.subnet_ip_digit}.128.0/19", "10.${var.subnet_ip_digit}.160.0/19"]
  database_subnets    = ["10.${var.subnet_ip_digit}.192.0/24", "10.${var.subnet_ip_digit}.193.0/24", "10.${var.subnet_ip_digit}.194.0/24"]
  elasticache_subnets = ["10.${var.subnet_ip_digit}.195.0/24", "10.${var.subnet_ip_digit}.196.0/24", "10.${var.subnet_ip_digit}.197.0/24"]

  azs = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # Logging VPC traffic
  enable_flow_log                      = true
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true

  # tags required to enable automatic subnet discovery by load balancers or ingress controllers
  # more info at https://aws.amazon.com/premiumsupport/knowledge-center/eks-vpc-subnet-discovery/
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.project}-${var.env}" = "shared"
    "kubernetes.io/role/elb"                          = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.project}-${var.env}" = "shared"
    "kubernetes.io/role/internal-elb"                 = 1
  }
}
