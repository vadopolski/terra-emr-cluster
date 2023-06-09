terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}


resource "aws_emr_cluster" "example_cluster" {
  name          = "example-emr-cluster"
  release_label = "emr-6.4.0"  # Replace with the desired EMR release version

  applications {
    name = "Spark"
  }

  applications {
    name = "Hive"
  }

  applications {
    name = "Hue"
  }

  visible_to_all_users = true

  instances {
    master_instance_type = "m5.xlarge"  # Replace with your desired instance type
    core_instance_type   = "m5.xlarge"  # Replace with your desired instance type
    instance_count       = 2  # Set the desired number of core nodes
  }

  ec2_attributes {
    key_name               = "terr06ppk"  # Replace with the name of your key pair
    subnet_id              = "your-subnet-id"  # Replace with the ID of your subnet
    emr_managed_master_security_group = [aws_security_group.terraform_ec2_security.name]  # Replace with the ID of your master security group
    emr_managed_slave_security_group  = [aws_security_group.terraform_ec2_security.name]  # Replace with the ID of your slave security group
  }
}


resource "aws_default_vpc" "main" {
  tags = {
    Name = "Main"
  }
}

