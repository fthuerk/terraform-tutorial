# Change Infrastructure

## Create a new resource

Now add an additional file in the same directory as `main.tf` with name `network.tf`. Here we will put all information required for creating a vnet.

```tf
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-terraform-tutorial"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
```

We can now reference the resource group name and the location from the resource group properties.

```tf
terraform apply
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/rg-terraform-tutorial]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_virtual_network.vnet will be created
  + resource "azurerm_virtual_network" "vnet" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + dns_servers         = (known after apply)
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "vnet-terraform-tutorial"
      + resource_group_name = "rg-terraform-tutorial"
      + subnet              = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_virtual_network.vnet: Creating...
azurerm_virtual_network.vnet: Creation complete after 5s [id=/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/rg-terraform-tutorial/providers/Microsoft.Network/virtualNetworks/vnet-terraform-tutorial]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## Modify an existing resource

Any resource can also be changed by simply modifying the resource definition.

```tf
resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-tutorial"
  location = "westeurope"

  tags = {
    Environment = "Terraform Getting Started"
    Team = "DevOps"
  }

}
```

The terraform apply command consequently shows then the plan and the resources that were changed.


<details>
  <summary><pre data-role="codeBlock" data-info="tf" class="language-tf tf"><code>terraform apply
</code></pre></summary>

```tf
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/da35404a-2612-4419-baef-45fcdce6045e/resourceGroups/rg-terraform-tutorial]
azurerm_virtual_network.vnet: Refreshing state... [id=/subscriptions/da35404a-2612-4419-baef-45fcdce6045e/resourceGroups/rg-terraform-tutorial/providers/Microsoft.Network/virtualNetworks/vnet-terraform-tutorial]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be updated in-place
  ~ resource "azurerm_resource_group" "rg" {
        id       = "/subscriptions/da35404a-2612-4419-baef-45fcdce6045e/resourceGroups/rg-terraform-tutorial"
        name     = "rg-terraform-tutorial"
      ~ tags     = {
          + "Environment" = "Terraform Getting Started"
          + "Team"        = "DevOps"
        }
        # (1 unchanged attribute hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Modifying... [id=/subscriptions/da35404a-2612-4419-baef-45fcdce6045e/resourceGroups/rg-terraform-tutorial]
azurerm_resource_group.rg: Modifications complete after 1s [id=/subscriptions/da35404a-2612-4419-baef-45fcdce6045e/resourceGroups/rg-terraform-tutorial]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
```
</details>


