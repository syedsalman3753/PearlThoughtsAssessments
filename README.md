# PearlThoughtsAssesments

## Prerequisites
- An AWS account with programmatic access (Access Key ID and Secret Access Key)
- A key pair (.pem) for SSH access to the EC2 instance
- A Docker Hub account to host container images

## 1. Clone the repository
* Clone the project repository on your local or controller machine:
  ```
  git clone https://github.com/syedsalman3753/PearlThoughtsAssessments.git -b main
  cd PearlThoughtsAssessments
  ```

## 2. Terraform to set up EC2 instance

* Navigate to the terraform directory:
  ```bash
  cd terraform
  ```
* Configure AWS credentials as environment variables:
  ```bash
  export AWS_ACCESS_KEY_ID='XXXXXX'
  export AWS_SECRET_ACCESS_KEY='YYYYYY'
  ```
* Initialize Terraform:
  ```bash
  terraform init
  ```
* Preview infrastructure changes:
  ```
  terraform plan
  ```
* Apply the Terraform plan to create resources:
  ```
  terraform apply
  ```
  Note: Once applied, note down the EC2 instance's Public IP from the output.

## 3. CI/CD Setup with GitHub Actions

* Configure the following GitHub Secrets under your repository settings:
* | Secret Name                | Description                                  |
  | -------------------------- | -------------------------------------------- |
  | `ACTOR_DOCKER_HUB`         | Docker Hub username                          |
  | `DEV_NAMESPACE_DOCKER_HUB` | Docker Hub account namespace                 |
  | `RELEASE_DOCKER_HUB`       | Docker Hub access token or password          |
  | `EC2_HOST`                 | Public IP of the provisioned EC2 instance    |
  | `EC2_SSH_KEY`              | Contents of the EC2 .pem private key         |
  | `EC2_USER`                 | Username for the EC2 instance (e.g., ubuntu) |

* Push your changes to the main branch to trigger the GitHub Actions workflow.

## 4. Infrastructure Automation with Ansible

* Navigate to the Ansible directory:
  ```bash
  cd ansible
  ```
* Edit the hosts.ini file to include:

* Run the playbook to deploy the application:
  ```bash
  ansible-playbook -i hosts.ini ansible-deployment.yaml
  ```
* Access the application via curl or open it in a browser.
  ```
  curl http://<public-ip>:80/
  ```

## 5. GitHub Actions Workflow Update

* After the first deployment is successful, update your GitHub Actions workflow to enable deployment on every push:

  In `.github/workflows/deploy.yml`, set the environment variable:
  ```
  jobs:
    build-and-deploy:
      runs-on: ubuntu-latest
      env:
        ...
        ...
        EC2_CREATE: 'true'
  ```
  This allows the workflow to SSH into the EC2 instance and update the deployed Docker service with the latest images.


