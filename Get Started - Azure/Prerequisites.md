# Resource Group

* Terraform CLI
* Azure CLI
* Azure Account and Credentials

```tf main.tf 
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
  name     = "myTFResourceGroup"
  location = "westus2"
}
```

## Terraform CLI

See also [Installation](/Preparations/Installation.md).

## Azure CLI

```
brew update && brew install azure-cli
```

## Azure Account and Credentials

### Login

You can login to your Azure account via the az Cli.

```
az login
```

### Service Principal

Alternatively you can also create a service principal with Client ID and Client Secret.

```
az ad sp create-for-rbac --role="Contributor" --scopes="subscriptions/<SUBSCRIPTION_ID>"

```

Then use the values for environmental variables.

```
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"
``` 

