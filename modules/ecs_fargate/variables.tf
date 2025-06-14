variable "project_name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "sg_id" {}
variable "execution_role" {}
variable "task_role" {}
variable "rds_endpoint" {}
variable "cloudfront_url" {}
