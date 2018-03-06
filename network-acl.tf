
variable "acl-id" {}

variable "offset" {

 default = "1"
 description = "Prevent Other Collisions from multiple module definitions."

}

##########################
# Ingress - Maps of rules
##########################
# Takes a list of 'ingress-rules' where each list item is a Map with the following keys
#  action: ether "allow" or "deny"
#  from-port: a port number
#  to_port:   a port number
#  protocol: A string like "tpc" or "-1"
# Additionally uses the 'ingress-cidrs'
resource "aws_network_acl_rule" "ingress-rules-and-cidr-list" {

  count = "${var.create ? local.ingress-join-size : 0}"

  network_acl_id = "${var.acl-id}"
  egress              = false

  rule_number     = "${lookup( local.ingress-joined-rules-cidrs[count.index], "rule-number", "")}"
  rule_action     = "${lookup( local.ingress-joined-rules-cidrs[count.index], "action", "")}"

  cidr_block     = "${lookup(local.ingress-joined-rules-cidrs[count.index], "cidr-block", "")}"

  from_port    = "${lookup(local.ingress-joined-rules-cidrs[count.index], "from-port", "")}"
  to_port     = "${lookup(local.ingress-joined-rules-cidrs[count.index], "to-port", "")}"
  protocol    = "${lookup(local.ingress-joined-rules-cidrs[count.index], "protocol", "")}"

}


#################
# End of ingress
#################

##################################
# Egress - List of rules (simple)
##################################
resource "aws_network_acl_rule" "egress-rules-and-cidr-list" {

  count = "${var.create ? local.egress-join-size : 0}"

  network_acl_id = "${var.acl-id}"
  egress              = true

  rule_number     = "${lookup( local.egress-joined-rules-cidrs[count.index], "rule-number", "")}"
  rule_action     = "${lookup( local.egress-joined-rules-cidrs[count.index], "action", "")}"

  cidr_block     = "${lookup(local.egress-joined-rules-cidrs[count.index], "cidr-block", "")}"

  from_port    = "${lookup(local.egress-joined-rules-cidrs[count.index], "from-port", "")}"
  to_port     = "${lookup(local.egress-joined-rules-cidrs[count.index], "to-port", "")}"
  protocol    = "${lookup(local.egress-joined-rules-cidrs[count.index], "protocol", "")}"

}

################
# End of egress
################
