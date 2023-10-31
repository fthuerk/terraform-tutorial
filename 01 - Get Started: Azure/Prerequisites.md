# First Steps

## Resource Group

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
  name     = "rg-tf-tutorial"
  location = "westus2"
}
```

