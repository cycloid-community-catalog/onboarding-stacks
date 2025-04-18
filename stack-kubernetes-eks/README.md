# AWS EKS

### Prerequisites
Create an EC2 key pair named exactly `cycloid` with a RSA key. This key will be provisionned on the ndoes.

### What it does ?
It creates:
* **VPC**
* **AWS EKS cluster**
  * **aws loadbalancer controller**: listens for service type `LoadBalancer` and creates ALB. Used to create ALB on top on nginx controller
  * **vpc cni**: created via addon, used to provide networking via AWS subnet
  * **cert manager**: automatically creates certificates via Let's Encrypt
  * **ebs csi driver**: manages PVC for EBS volume
  * **efs csi driver**: manages PVC for EFS volume
  * **external dns**: listens `ingress` and create Route53 records pointing on nginx controller ALB
  * **fluent bit**: forward k8s logs to cloudwatch
  * **nginx ingress controller**: redirect traffic to the right service
  * **metrics-server**: collects CPU/memory metrics used by pod HPA

### How use kubectl ?

Check pipeline access job

```bash
aws eks --region ${AWS_DEFAULT_REGION} update-kubeconfig  --name ${CLUSTER_NAME}
```

### How to access the ingress-controller ?

via the AWS ALB
