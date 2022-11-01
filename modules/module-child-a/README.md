[![MIT License][license-shield]][license-url]

# Terraform Module Template Boilerplate

<img alt="Terraform" src="https://www.datocms-assets.com/2885/1620155439-blog-library-product-terraform-aws-logomarks.jpg" width="480px">

## An Overview

This template gives a jump start to your Terraform project as a DevOps Engineer tool. A boilerplate using Terraform's [Standard Module Structure](https://www.terraform.io/language/modules/develop/structure)
a.k.a. Terraform Module boilerplate.

You may be overwhelmed by reading Terraform's official documentation, so I might think this template is useful.

When you are dealing with a complex project, learning the Terraform module is indeed a heavy lift.

## Getting Started
Before you get started, you need to have the following:

### Requirements

* [Terrraform](https://www.terraform.io/)'s basic as an infrastructure as code tool that lets you build, change, and version cloud and on-prem resources safely and efficiently.
* Personal Computer (i.e. Laptop or Desktop)
* Command Line Interface (Linux) or PowerShell (Windows) Basics

### Installing
I prefer not to talk about it here, so go over to their official [Terraform Install](https://learn.hashicorp.com/tutorials/terraform/install-cli) documentation

When you're in your favorite `CLI` terminal, type in
```bash
terraform --help
```
.. and you're ready to go

### Executing program

* After you've downloaded this archive, navigate to the project folder using your CLI or Terminal command tool.

```code
git clone https://github.com/esstat17/Terraform-Module-Template-Boilerplate.git
cd Terraform-Module-Template-Boilerplate
```

Basically, to initialize the script
* Initializing the code and installing dependency packages
```code
cd project-folder/ && \
./setup.sh
```
To undo all provisions
* Undo all commands above or revert them to the 0 state.
```code
git checkout HEAD -- terraform.tf && terraform init -migrate-state -force-copy && terraform destroy -auto-approve && echo "# edited" >> ./terraform.tf
```

## The File Tree

You can find the file tree below with a commented label.

```bash
.
└── terraform-module-template
    ├── CHANGELOG.md
    ├── LICENSE
    ├── main.tf # ROOT main.tf
    ├── modules
    │   ├── module-child-a
    │   │   ├── CHANGELOG.md
    │   │   ├── LICENSE
    │   │   ├── main.tf # CHILD main.tf
    │   │   ├── outputs.tf
    │   │   ├── README.md
    │   │   ├── terraform.tf
    │   │   └── variables.tf # Reading values from INPUT variables
    │   └── module-child-b
    ├── outputs.tf
    ├── README.md
    ├── terraform.tf
    └── variables.tf # INPUT variables in the root main.tf
```
You can read more infromation on [Standard Module Structure](https://www.terraform.io/language/modules/develop/structure).

## Help

Just reach me if you need help.


## Authors

Contributors names and contact info

[@esstat7](https://twitter.com/esstat17)

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
[license-shield]: https://img.shields.io/github/license/esstat17/Terraform-Module-Template-Boilerplate.svg?style=for-the-badge
[license-url]: https://github.com/esstat17/Terraform-Module-Template-Boilerplate/blob/main/README.md
Starting your Terraform project is made easy using this template.