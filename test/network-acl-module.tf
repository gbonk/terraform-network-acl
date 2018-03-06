
# Allow the HQ to ssh into the network
module "acl-ssh" {

  source = ".."

  acl-id       = "${aws_network_acl.public.id}"
  ingress-cidr = "123.456.78.910/32"

  ingress-rules = [
    {
      action = "allow"
      from-port   = 22
      to-port     = 22
      protocol    = "tcp"
    }
  ]

}

# Allow the general public to access the UI over HTTPs
module "acl-http" {

  source = ".."

  acl-id       = "${aws_network_acl.public.id}"
  offset = "100"

  ingress-cidr = "0.0.0.0/0"

  ingress-rules = [
    {
      action = "allow"
      from-port   = 443
      to-port     = 443
      protocol    = "tcp"
    }
  ]

}
