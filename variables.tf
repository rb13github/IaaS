#############
## AWS
#############

variable "aws_profile" {
  description = "AWS Profile"
  default     = ""
}

variable "region" {
  description = "Region where resources are deployed"
}

variable "project_name" {
  description = "Project name"
}

variable "env_type" {
  description = "Free text, single word description of the environment type"
  default     = "dev"
}