output "key_name" {
  value = "${aws_key_pair.default.key_name}"
}

output "security_group_id" {
	value = "${aws_security_group.allow_ssh.name}"
}
