# First Steps

## Configuration

First, we need to create a resource group. For this create a file main.tf with the following content.

```tf
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-tutorial"
  location = "westeurope"
}
```

### Terraform Block

The `terraform {}` block contains Terraform settings, including the required providers Terraform will use to provision your infrastructure. 

### Providers

The `provider` block configures the specified provider, in this case `azurerm`. A provider is a plugin that Terraform uses to create and manage your resources. You can define multiple provider blocks in a Terraform configuration to manage resources from different providers.

### Resources

Use `resource` blocks to define components of your infrastructure. A resource might be a physical component such as a server, or it can be a logical resource such as a Heroku application.


## Initialize
With the initialization of the project, terraform will fetch all required providers and create local structures.

```tf
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 3.0.2"...
- Installing hashicorp/azurerm v3.0.2...
- Installed hashicorp/azurerm v3.0.2 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!
```

### Local Directory Structure
This will download the required providers and copy it to the `.terraform` directory. Note that there is a lot of information about the provider stored in the directory structure.

```
.
├── .terraform
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── azurerm
│                   └── 3.0.2
│                       └── darwin_arm64
│                           └── terraform-provider-azurerm_v3.0.2_x5
├── .terraform.lock.hcl
└── main.tf
```
The `.terraform.lock.hcl` ensures that the `terraform init` command can only be run with the initially set provider versions. This might be important when collaborating to fix versions. It can still be updated with `terraform init -upgrade`.

#### Dev Override
There are also ways to tell terraform to use locally installed binaries of providers (e.g. for testing). Later sections will go deeper on this topic.

### Format and validate

The `terraform fmt` command automatically updates configurations in the current directory for readability and consistency.

```tf
provider "azurerm" {
features {   }
}
```

This would be transformed to

```tf
provider "azurerm" {
  features {}
}
```

In addition, the syntax can be checked with `terraform validate`.

```tf
$ terraform validate
Success! The configuration is valid.
```

## Plan Changes

```tf
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "rg-terraform-tutorial"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

Navigate to the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups) in your web browser to validate the resource group.

## Apply Changes
Applying the changes also presents you with a plan by default so you can review the changes.

```tf
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "rg-terraform-tutorial"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 1s [id=/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/rg-terraform-tutorial]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## Inspect Terraform State

When you apply your configuration, Terraform writes data into a file called `terraform.tfstate`. This file contains the IDs and properties of the resources Terraform created so that it can manage or destroy those resources going forward. You can show the state by using `terraform show`.
Note that the state should not be checked into source control. However, if you are working with other teams, it is a good idea to store the data somewhere remotely. 

```tf
$ terraform show
# azurerm_resource_group.rg:
resource "azurerm_resource_group" "rg" {
    id       = "/subscriptions/<SUBSCRIPTION_ID>//resourceGroups/rg-terraform-tutorial"
    location = "westeurope"
    name     = "rg-terraform-tutorial"
}
```

If the state file is getting bigger you can also display the name of all created resources with `terraform state list`.

```tf
$ terraform state list
azurerm_resource_group.rg
```
By default, the state file will be created in your current directory and is actually also formated as a json and therfore human readable.

```
.
├── .terraform
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── azurerm
│                   └── 3.0.2
│                       └── darwin_arm64
│                           └── terraform-provider-azurerm_v3.0.2_x5
├── .terraform.lock.hcl
├── main.tf
└── terraform.tfstate
```

