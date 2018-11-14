## Contents

- [Motivation](#motivation)
- [Requirements](#requirements)
- [Usage](#usage)
  - [Environment Variables](#environment-variables)

## Motivation

The purpose of this repository is to demonstrate a fully automated image deployment and testing pipeline.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html)
- [Packer](https://packer.io/downloads.html)
- [Vagrant](https://www.vagrantup.com/downloads.html)

## Usage

This repository builds Amazon Machine Images (AMIs) using software called Packer. After Packer finishes the build, it uploads an artifact (AMI) to the AWS account associated with the AWS Access Key ID and AWS Secret Access Key provided by the user. The AMI is then available for use by Vagrant.

The [main.tf](main.tf) file wraps the Packer [build](https://packer.io/docs/commands/build.html) command in a Terraform configuration file and creates the security group used via the Vagrant AWS provider to allow incoming SSH connections.

    $ terraform init
    $ terraform apply

If the Terraform provisioning is successful, it creates a file named `packer-manifest.json` which contains the AMI ID of the artifact created via Packer. The [Vagrantfile](Vagrantfile) then uses this data, as well as data from the Terraform state to create an EC2 instance using the [vagrant-aws](https://github.com/mitchellh/vagrant-aws) provider. To create a new EC2 instance, invoke the following command:

### Environment Variables

The following environment variables are required to use this repository.

| Name                    | Required           |
|-------------------------|:------------------:|
| `AWS_ACCESS_KEY_ID`     | :heavy_check_mark: |
| `AWS_SECRET_ACCESS_KEY` | :heavy_check_mark: | 
