#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-2df66d3b
#
# Your subnet ID is:
#
#     subnet-75a08610
#
# Your security group ID is:
#
#     sg-4cc10432
#
# Your Identity is:
#
#     testing-panda
#

resource "aws_instance" "web" {
  ami                    = "ami-2df66d3b"
  subnet_id              = "subnet-75a08610"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-4cc10432"]

  tags {
    Identity = "testing-panda"
    Name = "web ${count.index +1}/${var.count}"
    Title = "God"
  }
  count = "${var.count}"
}

variable "count" {
  default = "2"
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

output "public_ip" {
  value = [ "${aws_instance.web.*.public_ip}" ]
}

output "public_dns" {
  value = [ "${aws_instance.web.*.public_dns}" ]
}

terraform {
  backend "atlas" {
    name         = "cuongvoong/training"
  }
}
