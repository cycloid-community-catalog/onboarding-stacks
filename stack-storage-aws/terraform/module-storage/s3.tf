module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket        = var.s3_bucket_name
  force_destroy = var.s3_force_destroy

  tags = merge(local.merged_tags, {
    Name = var.s3_bucket_name
    org = var.customer
    project = var.project
    env = var.env
    role = "s3"
  })
}