require 'json'

Vagrant.require_version ">= 2.2.0"

Vagrant.configure("2") do |config|
  manifest = JSON.parse(File.read("packer-manifest.json"))
  aws_ami = manifest["builds"][-1]["artifact_id"].split(":")[-1]

  # Ensure that the user has the `vagrant-aws` plugin installed.
  config.vagrant.plugins = "vagrant-aws"
  config.vm.box = "dummy"
  config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

  config.vm.provider "aws" do |aws, override|
    aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
    aws.ami = aws_ami
    aws.keypair_name = `terraform output key_name`.strip
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    aws.security_groups = [
      `terraform output security_group_id`.strip
    ]

    override.ssh.private_key_path = File.expand_path("~/.ssh/id_rsa")
    override.ssh.username = "ubuntu"
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
  end

  config.vm.synced_folder ".", "/vagrant", type: "rsync"
end
