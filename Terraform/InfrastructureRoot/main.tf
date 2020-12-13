
module "modules" {
  source            = "../Infrastructure"
  Network           = ""
  Environment       = ""
  Environment-Short = ""
  aws_region        = "us-east-2"
}
