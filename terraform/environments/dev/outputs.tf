output "vpc_id" {
    value = module.vpc.vpc_id
}

output "public_subnet_1a_id" {
    value = module.vpc.public_subnet_1a_id
}

output "public_subnet_1b_id" {
    value = module.vpc.public_subnet_1b_id
}

output "ec2_sg_id" {
    value = module.vpc.ec2_sg_id
}

output "rds_sg_id" {
    value = module.vpc.rds_sg_id
}