# ELRR Build (Jenkins)

This directory contains the code to install, configure, and run Jenkins associated with the Enterprise Learner Record Repository project.

## Intended use

Intended use of this code is that a user could reference the steps below, including the associated scripts within this repository, to build a Jenkins CI/CD server within their environment. The configuration scripts within this environment provide the baseline Jenkins configuration. Developers may leverage their own configuration scripts and supplied Groovy scripts to update the Jenkins instance to their liking.

## Capabilities and limitations

The code in this repository leverages Docker images for running majority of the core applications. While the code has been tested on AWS EC2 instances, the code should be able to run on any major cloud platform with parameter tweaks, but has not been verified. The current code base utilizes separate virtual machines (VMs) for each of the core components

In the future, the development team will explore running the ELRR suite using Docker Compose and/or on Kubernetes.

## Directions for use

The following steps are related to running a 2-node set-up with a Jenkins Master and Jenkins Agent using Docker. The Jenkins Agent server is essentially a 'Docker host' which dynamically spins up/down Jenkins Agent containers, as needed.

### Install the Jenkins Master server

Pre-requisites:
- A Linux VM (Ubuntu 18.04) has been stood-up and configured (2 vCPU and 4 GB is recommended at minimum)
- You are able to SSH into your VM
- TCP 80/443 ports (inbound) are open to the Internet
- TCP 8083 port (inbound) is opened to your IP address
- Public DNS for your VM

First, SSH into the VM. Once in the VM, run the below command to clone the ELRR infrastructure repo to the local machine:
```console
git clone https://github.com/US-ELRR/elrr-infrastructure.git
```
Once cloned successfully, navigate to the src directory for jenkins `cd elrr-infrastructure/src/jenkins`. Within the directory, execute the following command to run the shell script to bootstrap the installation of Jenkins:
```console
. ./jenkins_install.sh
```
After the shell script completes, Jenkins Master node should be running in the background. Now the Jenkins Master node is ready for first-time log-in configuration. A one-time admin password is required to access the front-end, use the below command to pull the secret one-time password from the container *save the password for the next step*
```console
sudo docker exec ${CONTAINER_ID or CONTAINER_NAME} cat /var/jenkins_home/secrets/initialAdminPassword
```
Open a browser window and enter the Public DNS for your Jenkins VM, including port 8083 (e.g., <ec2-vm-ip-info>.us-east-2.compute.amazonaws.com:8083). The 'Unlock Jenkins' screen should open; paste in the password from the previous step.

Next, select `Install suggested plugins`(NOTE: you may choose `Select plugins to install` if you're experienced with configuring Jenkins), then create the first admin user credentials. You may be prompted to restart Jenkins, otherwise you're all set with installing Jenkins!

### Configure the Jenkins Master server

Pre-requisites:
- A Linux VM (Ubuntu 18.04) has been stood-up and configured (2 vCPU and 4 GB is recommended at minimum)
- TCP 80/443 ports (inbound) are open to the Internet
- TCP 8083 port (inbound) is opened to the Jenkins Master VM (previous section)
- TCP 22 port is opened between the Jenkins Master VM (previous section)
- TCP 32768 - 60999 and 4243 are open between Jenkins Master VM (previous section)
- Public DNS for your VM

On the Jenkins home screen left panel, navigate to 'Manage Jenkins -> Manage Plugins' screen. Select the 'Available' tab and search for `Docker plugin` and select the option `Docker plugin` and choose `Install without restart`. NOTE: There are many Docker plugins, do not download these other options.

After the plugin has installed successfully, navigate back to the `Manage Jenkins` page.

Next we will establish the connection between the Jenkins Master to the Jenkins Agent VM. In our case, we're using the Jenkins Agent VM as a 'Docker host' that will spin up Jenkins Agents as containers on-demand. The Jenkins Master connects to the Jenkins Agent VM via SSH and creates containers via the Docker API.

On the `Manage Jenkins` page, select `Manage Nodes and Clouds`, then select `Configure Clouds` from the left toolbar.
1. In the `Add a new cloud` drop-down, select 'Docker' - change the name to `elrr-jenkins-agent`.
2. Select the `Docker Cloud details...` button and within the 'Docker Host URI' add in the following `tcp://<private-ip-of-jenkins-agent-VM>:4243`. To ensure the connection works, select the 'Test Connection' button to ping the Jenkins Agent VM - a successful response looks like `Version = 20.10.5, API Version = 1.41`. NOTE: If there are connectivity issues, please ensure that TCP port 4243 (inbound) is opened on the Jenkins Agent VM for the Jenkins Master VM IP address.
3. Ensure the 'Enalbed' checkbox is selected; leave the rest of the values as default

Next we will configure the container that will be started as a Jenkins Agent:
1. Select `Docker Agent templates` and `Add Docker Template`
2. Make the 'Labels' a unique name (e.g., elrr-jenkins-agent)
3. Update 'Name' to be the same as 'Step #2'
4. Update the 'Docker Image' to `jenkins/ssh-agent:latest-jdk11`
5. Update 'Connect method' to `Connect with SSH` and SSH Key to `Inject SSH Key`. Leave the rest of the values as defaults.
6. Change 'Pull strategy' to `Pull Once and Update Latest`

Select 'Save' and you've now successfully configured a Jenkins Master with a Jenkins Agent using Docker!

## Further resources

For more details on Jenkins, please refer to the following documentation:
* [Jenkins - Docker](https://www.jenkins.io/doc/book/installing/docker/)
* [Jenkins - Docker Agent](https://plugins.jenkins.io/docker-plugin/)
