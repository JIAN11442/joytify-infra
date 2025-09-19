variable "loadbalancer_ip" {
  description = "DigitalOcean Loadbalancer IP"
  type        = string
}

variable "aws_secret_name" {
  description = "AWS Secret Name"
  type        = string
}

variable "cert_manager_email" {
  description = "Email for the cert manager"
  type        = string
}