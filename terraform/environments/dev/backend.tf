terraform {
    backend "s3" {
        bucket = "cloudshelf-tf-state-126104434582"
        key    = "dev/terraform.tfstate"
        region = "ap-southeast-1"
        use_lockfile = true
        encrypt = true

    }
}