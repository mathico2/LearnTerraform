
module "modules" {
  source            = "../vms"
  Network           = "P"
  Environment       = "Production-1"
  Environment-Short = "P1"
  aws_region        = "us-east-2"
  key_name          = "test-key"
}
