provider "azurerm" {
  environment     = "public"
  subscription_id = "7576f783-0404-4171-be43-0c4c10e5f0b3"
  version         = "1.29.0"
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = "o360-demo-sandbox-RG"
  location = "East US"
}

resource "azurerm_virtual_network" "sharedservicesvnet" {
  name                = "o360-demo-sandbox-bastion"
  location            = "East US"
  resource_group_name = "o360-demo-sandbox-RG"
  address_space       = ["10.0.0.0/27"]
}

/*data "azurerm_storage_account" "bastion_storage_account" {
  name                = "o360-demo-sandbox-stgac"
  resource_group_name = "o360-demo-sandbox-bastion"
}*/


module "azurebastion" {
  source = "./azurebastion"
  IP_NAME                  = "o360-demo-sandbox-demo-ip"
  BASTION_NAME             = "o360-demo-sandbox-demo-name"
  SUBNET_NAME              = "AzureBastionSubnet"
  ARM_LOCATION             = "East US"
  ARM_RESOURCEGROUP        = "o360-demo-sandbox-RG"
  ARM_ENVIRONMENT_NAME     = "demo"
  CUSTOMER_PREFIX          = "360"
  CUSTOMER_COSTCENTRE      = "360"
  CUSTOMER_APPLICATION     = "Azure-Bastion-demo"
  BASTIONSUBNETCIDR        = ["10.0.0.0/27"]
  BASTIONSUBNETCIDR_PREFIX = "10.0.0.0/27"
  VNETNAME                 = "o360-demo-sandbox-bastion"
 # STORAGE_ACCOUNT          = "o360-demo-sandbox-sa"
}

