# PearlThoughtsAssesments

## Prerequisites
* Create a key-pair which is used to log in to ec2 instance via ssh.
* Create an EC2 instance with Security group with inbound ports 80,22 and outbound to all.
* Ensure user has passwordless sudo access in console machine 

## clone the repository
## Terraform to set up EC2 instance

```bash
cd terraform
```
```bash
export AWS_ACCESS_KEY_ID='XXXXXX'
export AWS_SECRET_ACCESS_KEY='YYYYYY'
```

```bash
terraform init
```
```
terraform plan
```
```
terraform apply
```

Note down the public ip

## CI/CD with GitHub Actions

* Set the below secrets in github actions secrets
  ```
  ACTOR_DOCKER_HUB              - dockerhub username
  DEV_NAMESPACE_DOCKER_HUB      - dockerhub account id
  RELEASE_DOCKER_HUB            - dockerhub user's login token / password
  ```
* Push the changes to github repository
* it will create docker image and push to docker hub

## Infrastructure Automation with Ansible

* Update the hosts name, username, pem key in hosts.ini file
* 
## Update deploy.yml github actions
```
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    env:
      ...
      ...
      EC2_CREATE: 'true'
```

```
EC2_HOST
EC2_SSH_KEY
EC2_USER
```