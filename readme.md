[![MIT License][license-shield]][license-url]

# Provisioning AWS with S3 Bucket DynamoDB as Backend Using Terraform Ad-Hoc Script

<img alt="Terraform" src="https://www.datocms-assets.com/2885/1620155439-blog-library-product-terraform-aws-logomarks.jpg" width="480px">

## Intro

Why was this repository created? Well, using S3 as a Backend is somewhat tricky. You need to provide resources (such as S3 Buckets) first, before adding the S3 block `backend "s3" {}` block. It is not good practice to manually create S2 Buckets since the AWS provision's life cycle should rely on Terraform State File. You will occasionally encounter errors when you do that. Like what you can see below:
```bash
Error: Error inspecting states in the "local" backend:
S3 bucket does not exist.
```

So what's this setup.sh can do is to create S3 Buckets and dynamoDB resources first and run the terraform provision again with the "S3" backend. Specifically, this repo solves the following:

* Avoiding S3 Bucket Common Errors
* Avoiding conflicts on deployments among developers using Terraform State Locking
* AWS profile and credentials checks

## Getting Started
Before you get started, you need to have the following:

### Requirements
* Terraform CLI
* [Git Bash](https://git-scm.com/downloads)
* AWS IAM account with `AdministratorAccess` priviledge
* AWS Local Authentication `aws configure`

### Cloning
I prefer not to talk about it here, so go over to their official [Terraform Install](https://learn.hashicorp.com/tutorials/terraform/install-cli) documentation

When you're in your favorite `CLI` terminal, type in
```bash
git clone https://github.com/esstat17/Terraform-S3-Backend-AWS-VPC-DynamoDB-Template.git
```
.. and you're good to go

### Executing program

* After you've downloaded this archive, navigate to the project folder using your CLI or Terminal command tool.

Change Directory to project folder and run the script
* Initializing the script, installing package dependencies, terraform plan and deployments
```bash
cd Terraform-S3-Backend-AWS-VPC-DynamoDB-Template/
```
To run the script
```bash
./setup.sh your-app-name
```
To undo all provisions
* Undo all commands above or revert them to the 0 state.
```bash
git checkout HEAD -- backend.tf && terraform init -migrate-state -force-copy && terraform destroy -auto-approve && echo "# edited" >> ./backend.tf
```

## Help

Just reach me if you need help.


## Authors

Contributors names and contact info

[@esstat17](https://twitter.com/esstat17)

## Version History
* 0.1.0
    * Initial Release

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

Inspiration, code snippets, etc.
* [Terraform Basics](https://www.terraform.io/intro)
* [Terraform Installation](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [Terraform Modules](https://www.terraform.io/language/modules/develop)

<!-- MARKDOWN LINKS & IMAGES -->
[license-shield]: https://img.shields.io/github/license/esstat17/Terraform-S3-Backend-AWS-VPC-DynamoDB-Template.svg?style=for-the-badge
[license-url]: https://github.com/esstat17/Terraform-S3-Backend-AWS-VPC-DynamoDB-Template/blob/main/README.md
Starting your Terraform project is made easy using this template.