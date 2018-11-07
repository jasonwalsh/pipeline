provider "aws" {}

resource "aws_security_group" "allow_ssh" {
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
}

resource "aws_key_pair" "default" {
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "null_resource" "default" {
  triggers {
    key_name = "${aws_key_pair.default.key_name}"
  }

  provisioner "local-exec" {
    command = "packer build -var 'ssh_keypair_name=${aws_key_pair.default.key_name}' packer/template.json"
  }
}
