output "elb_endpoint" {
  value = "http://${module.elb_endpoint.stdout}"
}
