# Web App on Cloud

A full stack application deployed on an AWS EC2 Instance.

## Detailed description

The project deploys a full stack application on a cloud server. It implements concepts like *containerization*, *CI/CD pipeline*, *infrastructure as code*, *configuration management*, *cloud computing* and *task automation*.


### Tools/Technologies used

- [**Nginx**](https://nginx.org/en/) - Nginx is a high-performance, open-source web server and reverse proxy server known for its scalability and efficiency in handling concurrent connections.

- [**Node.js**](https://nodejs.org/en) - Node.js is a JavaScript runtime built on Chrome's V8 engine, enabling server-side scripting to create scalable and high-performance web applications.

- [**Terraform**](https://www.terraform.io/) - Terraform is an open-source infrastructure as code software tool that allows users to define and provision infrastructure using a declarative configuration language.

- [**Ansible**](https://docs.ansible.com/ansible/latest/index.html) - Ansible is an open-source automation platform used for configuration management, application deployment, and task automation, emphasizing simplicity and ease of use.

- [**Jenkins**](https://www.jenkins.io/) - Jenkins is an open-source automation server that facilitates continuous integration and continuous delivery (CI/CD) for software development projects.

- [**Docker**](https://www.docker.com/) - Docker is a platform-as-a-service (PaaS) product that uses OS-level virtualization to deliver software in containers, enabling lightweight, portable, and consistent environments for applications.


### Pre-requisites to run the project

- An AWS account.
- Terraform must be installed on local system. Go to [this](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) link for reference.
- Git must be installed on local system to clone project.

### Steps to execute the project

A step by step series of instructions that will help you deploy the application

**Step 1** : Create a keypair locally using this command

    ssh-keygen -t rsa -b 2048 -f keypair
        
**Step 2** : Execute ec2.tf locally to create AWS EC2 Instance.

**Step 3** : SSH into newly created EC2 Instance, install Ansible, clone this repo then install docker and jenkins using ec2_config.yml file after navigating into cloned repo. The playbook file will also handle configurations and permissions required to run Docker in Jenkins.

**Step 4** : Launch Jenkins  on EC2 and install Docker and Github plugins.

**Step 5** : Create a pipeline job, add Jenkinsfile from repo.

**Step 6** : Execute job.

**Step 7** : Hit the EC2 public address at port 3000 to access application.
