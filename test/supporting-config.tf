
provider "aws" {

  region = "us-east-2"

  profile = "default"
}

resource "aws_vpc" "vpc" {

    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {

  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "ig" {

  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "public" {

  route_table_id  = "${aws_vpc.vpc.default_route_table_id}"

  gateway_id = "${aws_internet_gateway.ig.id}"

  destination_cidr_block = "0.0.0.0/0"
}

