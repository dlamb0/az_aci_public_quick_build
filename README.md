# Azure Web App - Terraform

Deploys an Azure Linux Web App running a Docker container, using Terraform. Hosted via Azure Container Instances.

## Resources Deployed

- **Azure Container Group** (`<app_base_name>-acg`) — Linux, Docker container, public URL on `.azurecontainer.io`
- **Azure User Assigned Identity** (`<app_base_name>-identity`) — User Identity for ACG to pull image from Azure Registry
- **Azure Role Assignment** - Add AcrPull role to our User Identity

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) installed (>= 1.3)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- An active Azure subscription
- An Azure resource group
- An Azure container registry

---

## Setup & Usage

### 1. Login to Azure

```bash
az login
```

### 2. Find your Subscription ID

```bash
az account list --output table
```

### 3. Fill in your values

Edit `variables.tf` with your subscription ID, desired app name, email, etc.

```hcl
variable "subscription_id" {
  type      = string
  default   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  sensitive = true
}

variable "resource_group_name" {
  type    = string
  default = "your-resource-group"
}
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Preview what will be created

```bash
terraform plan
```

### 6. Deploy

```bash
terraform apply
```

Type `yes` when prompted. Terraform will output your Web App URL when complete.

> **Note:** The app may take 2–5 minutes to become available after deployment while Azure pulls the container image.

### 7. Tear down when done

```bash
terraform destroy
```

---

## Key Variables

| Variable | Default | Description |
|---|---|---|
| `subscription_id` | (required) | Azure Subscription ID |
| `resource_group_name` | (required) | Azure Resource Group |
| `app_base_name` | (required) | Base name, used for all resource names |
| `location` | `westus2` | Azure region |
| `acr_id` | (required) | Azure Container Registry Resource ID |
| `acr_login_server` | (required) | Azure Container Register Server URL |
| `container_image` | (required) | Container image to deploy |
| `owner_email` | (required) | Your email, applied as an owner tag |
| `environment` | `lab` | Tag applied to all resources |

---

## Notes

- **Azure Container Registry** Due to API rate limiting for Docker Hub, you must download any image from Docker, and upload it to ACR, or your image will likely fail to download.  Use the `az acr import` command, below is an example to do this for the Juice Shop image on Docker Hub.

```bash
az acr import \
  --name <acr_name> \
  --source docker.io/bkimminich/juice-shop:latest \
  --image juice-shop:latest
```

- **State** is stored locally in `terraform.tfstate`. Do not delete this file while resources are deployed.
