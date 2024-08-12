    terraform {
        required_version = "~> 1.8.4"
        required_providers {
            aws1 = {
                source = "hashicorp/aws"
                version = "~> 3.21"
            }
        }
        backend "s3" {
        bucket = "demo512"
        key = "terraform/state.tfstate"
        region = "us-east-1"
        }
    }

    provider aws1 {
        profile = "default"
        region = "us-east-1"
        alias = "silver"
    }