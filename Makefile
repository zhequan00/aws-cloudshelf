SSH_KEY=~/.ssh/cloudshelf-key.pem
EC2_HOST=18.139.166.215

ssh:
	ssh -i $(SSH_KEY) ubuntu@$(EC2_HOST)

plan:
	cd terraform/environments/dev && terraform plan

apply:
	cd terraform/environments/dev && terraform apply

destroy:
	cd terraform/environments/dev && terraform destroy