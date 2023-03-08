# Infrastructure

## Quick start

### Setup

Install Terraform CLI

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew update
```

Add a `terraform.tfvars` file to the root of the project with values for the variables required.

Log in to Terraform cloud then initialise the `dev` workspace locally.

```bash
terraform login
terraform init
```

### Making a change

Update existing Terraform resources or add new ones using existing code as a guide.

Validate your changes and, if successful, run a speculative plan to confirm changes.

```bash
terraform validate
terraform plan
```

Terraform will automatically run a plan whenever changes are committed to the workspace branch. If successful, the plan must be manually applied from the [cloud console](https://app.terraform.io/).

## Working with Terraform

### Terraform state

Terraform maintains a copy of the most recent changes in workspace state. The state is stored in the [Terraform Cloud workspace](https://app.terraform.io/) and is available locally as the workspace is configured to use a [remote backend](https://www.terraform.io/docs/language/settings/backends/remote.html).

State can be manipulated using the `terraform import` and `terraform state` commands.

To remove a manually deleted resource from state:

```bash
terraform state rm 'module.github["auth"].github_repository_environment.repo_env'
```

To add a manually created resource to state:

```bash
terraform import 'azurerm_resource_group.app' "/subscriptions/1278fa29-0ee5-4f10-a568-d00d37a86e03/resourceGroups/app-ticc-dev-ae-rg"
```

See `./scripts/state.sh for more examples.

## Hacks and TODOs

This repo is a work in progress and contains a number of hacks and TODOs. These are listed here for reference.

1. Adding a custom domain to Azure API Manager requires a TXT record with a domain identifer. Getting this value is not supported by Terraform so has been hardcoded (by environment).

## Useful links

- [Subnet calculator](https://subnetcalculator.info/CidrCalculator)
- [CIDR notation](https://www.ionos.com/digitalguide/server/know-how/cidr-classless-inter-domain-routing/)
# infrastructure
