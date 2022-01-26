module "dev_bucket" {
  source = "../"
  bucket_name = "dev_bucket"
  bucket_region = local.region
}