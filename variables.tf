#################
# network acl
#################
variable "create" {
  description = "Whether to create network acl and all rules"
  default     = true
}

##########
# Ingress
##########
variable "ingress-rules" {
  type = "list"
  description = "The List of Ingress Rules. Each item in the list is a map.  The Maps will be joined with the 'ingress-cidr'  "
}

variable "ingress-cidr" {
  type = "list"
  description = "List of IPv4 CIDR ranges to apply to all ingress rules"
}


#########
# Egress
#########
variable "egress-rules" {
  type = "list"
  description = "The List of Egress Rules. Each item in the list is a map. The Map will be joined with the 'egress-cidr'  "
  default     = [
    {
      action = "allow"
      from-port   = -1
      to-port     = -1
      protocol    = "-1"
    }
  ]
}

variable "egress-cidr" {
  type = "list"
  description = "List of IPv4 CIDR range to use on all egress rules"
  default     = ["0.0.0.0/0"]
}
