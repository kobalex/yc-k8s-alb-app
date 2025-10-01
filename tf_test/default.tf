terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.159.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
  
}

locals {
  folder_id = "b1gl4qfnobagda6d****"
  cloud_id  = "b1gbped5k8plskll****"
  zone      = "ru-central1-a"
}

provider "yandex" {
  # Configuration options
  cloud_id                 = local.cloud_id
  folder_id                = local.folder_id
  service_account_key_file = "C:\\Users\\АК\\Downloads\\authorized_key.json"
}