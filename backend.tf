terraform {
  backend "azurerm" {
    resource_group_name  = "sample-rg"
    storage_account_name = "demosstorages1"
    container_name       = "reports"
    key                  = "terraform-depend.tfstate"
  }
  }


