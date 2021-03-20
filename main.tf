##################################################
## Your variables
##################################################
variable "aws_access_key" {
  type = string
}
variable "aws_secret_key" {
  type = string
}
variable "aws_region" {
  default = "us-east-1"
}
variable "service_name" {
  default = "Nodejschess-env"
}
variable "service_description" {
  default = "Nodejs Chess by Mykola (group Lv-562)"
}
variable "app_name" {
  default = "nodejs-chess"
}
variable "app_name_description" {
  default = "Nodejs chess app"
}
##################################################
## AWS config
##################################################
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
}

##################################################
## Elastic Beanstalk config
##################################################
resource "aws_elastic_beanstalk_application" "eb_app" {
  name                      = var.app_name
  description               = var.app_name_description
}

resource "aws_elastic_beanstalk_environment" "eb_env" {
  name                      = var.service_name
  description               = var.service_description
  application               = var.app_name
  solution_stack_name       = "64bit Amazon Linux 2 v5.3.0 running Node.js 10"
  tier                      = "WebServer"
  
  # Tags of our group
  tags = {
    ita_group = "Lv-562"
  }

  # default vpc
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-0d36afcb2e15a0628"
  }
  # Subnet = us-east-1a
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-0596a00e724f9a1da"
  }

  # SecurityGroups = 	sg-08ef2c279f8656cd6 (default)
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "sg-08ef2c279f8656cd6"
  }

  # Role = aws-elasticbeanstalk-ec2-role (default)
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }

  # Type of instance
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }

  # Min instance
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
    resource  = ""
  }

  # Max instance
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "1"
    resource  = ""
  }

  # EnvironmentType = SingleInstance (or LoadBalancer)
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
    resource  = ""
  }
}