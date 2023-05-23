# Terraform-Project (CloudProxy-IaC)

 CloudProxy-IaC is a project that provisions a highly available infrastructure using Infrastructure as Code (IaC) principles.
It sets up a Virtual Private Cloud (VPC) with an Internet Gateway , subnets, an Application Load Balancers (ALB), and EC2 instances.
The architecture enables routing requests from an internet-facing ALB to Nginx reverse proxy instances in public subnets,
which then forward the requests to an internal ALB. 
The internal ALB directs the traffic to Apache web server instances in private subnets, serving the website content.

- The Terraform project incorporates a robust state management system to track and manage the infrastructure's state. This is achieved by configuring the project to store the state file in an S3 bucket and using DynamoDB to monitor and manage the state.

- When the Terraform project is executed, the state file, which contains information about the deployed infrastructure's current state, is uploaded instantaneously to an S3 bucket. This ensures that the state file is stored securely and centrally accessible.

- Additionally, DynamoDB is utilized as a backend for state locking and consistency. This means that when multiple users or processes attempt to modify the infrastructure concurrently, DynamoDB ensures that only one process can make changes at a given time, preventing conflicts and maintaining consistency.

- By leveraging S3 for storing the state file and DynamoDB for state locking and consistency management, the Terraform project ensures efficient and reliable state management. This allows for collaboration, scalability, and smooth orchestration of infrastructure changes, enhancing the overall management and control of the infrastructure deployed using Terraform.

- The project follows a modular approach by leveraging the concept of modules in Terraform. Modules allow for the creation of reusable, self-contained components that encapsulate infrastructure resources and configurations.

- In this project, various modules are defined to represent different logical components of the infrastructure. Each module focuses on a specific aspect, such as VPC creation, subnet configuration, load balancer setup, or EC2 instance provisioning.

## Note
 - You must have your own key in project working directory.
 ## How to use 
  - AWS-CLI
  ```
  sudo apt install awscli -y
  ```
  - Configure Your Credientials [ID,Access-Key,regoin,profile]
  ```
  aws configure
  ```
  - Terraform
  ```
  https://phoenixnap.com/kb/how-to-install-terraform
  ```
  - Clone Repository
  ```
  git clone git@github.com:hossamShawky/Terraform-Project.git
  ```
  - CD To Working Directory
  ```
  cd <your-dir>/Terraform-Project
  ```
  - Run 
  ```
  terraform workspace new dev
  ```
  - Run 
  ```
  terraform init
  ```
  
  - Run 
  ```
  terraform plan
  ```
  
  - Run [After Reviewing Type 'yes' to create resources]
  ```
  terraform apply
  ```
  - Then ips printed in public_ips.txt,private_ips.txt and public-load-balancer DNS printed in public-loadbalancer.txt copy  it and test in browser.
  ```
  cat public-loadbalancer.txt
  ```
  - > :warning: To Destroy All Resources Run [Type 'yes' to confirm]
  ```
  terraform destroy
  ```
### Customization
Feel free to customize the project as per your requirements. You can modify the VPC CIDR ranges, security groups, instance types, or add additional configurations as needed.

### Contributions
Contributions to enhance or expand this Terraform project are welcome! If you find any issues or have suggestions, please open an issue or submit a pull request.

### License
This project is licensed under the MIT License.