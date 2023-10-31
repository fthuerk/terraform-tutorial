# Terraform Installation

## OS X

All installations guides will be focussed on `OS X`. For futher details see https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli

```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```


## Autocomplete

Terraform also has autocomplete which is configured in the `.bashrc`.
```
terraform -install-autocomplete
```

# Cloud Provider CLI

Depending on your Cloud Provider, TF relies on the corresponding CLI.

## Azure CLI

To install Azure CLI use this command.
```
brew update && brew install azure-cli
```

## Azure Account and Credentials

### Login

You can login to your Azure account via the az Cli.

```
az login
az account set --subscription "<SUBSCRIPTION_ID>"
```

### Service Principal

Alternatively you can also create a service principal with Client ID and Client Secret.

```
az ad sp create-for-rbac \
--name terraform-tutorial-sp \
--role="Contributor" \
--scopes="subscriptions/<SUBSCRIPTION_ID>"
```

Then use the values for environmental variables.

```
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"
``` 

# Other
There are other tools which might be helpful but are not required for this tutorial.

## TF Env

Tf Env is a practical tool if you need to install different versions of TF.

https://github.com/tfutils/tfenv


```
brew install tfenv
tfenv install 0.7.0
```