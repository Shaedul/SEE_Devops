# Devops : Web based ImageGallery application

## Pre-requisites
### System Configuration

* Linux OS
* At least 16 GB RAM

### Software Setup

* VirtualBox(v 6.0, or higher)
 [Instructions to install here](https://www.virtualbox.org/wiki/Downloads)
 
* Vagrant (v 2.2.5, or higher)
 [Instructions to install here](https://www.vagrantup.com/downloads.html)
 Check the installed version : `vagrant --version`
 
* Ansible (v 2.7.5, or higher)
 [Instructions to install here](https://docs.ansible.com)
 Check the installed version :  `ansible --version`
 
* Maven (v 3.6.2, or higher)
 [Instructions to install here](https://maven.apache.org/download.cgi)
 Check the installed version :  `mvn -version`

Note : If you don't have git install before in your system, Just install by the command : `sudo apt-get install git-all`


# Automate build process

## Step 1 : Configure Integration Server
The main purpose of creating the VM that will work as an integration server. In the integration server, the server must have VCS property that developers can up to date their changes. If a change is detected by the integration server the build process will be starting again. 

1. Get to the directory
`cd ~/<git_root_folder>/SEE_Devops/pipeline/serverintegration`

2. Vagrant is used to create a Virtual Machine which acts as integration server.
`sudo vagrant up`

**Notes :**
* As we have Ansible playbooks,the VM automatically provisioned.
* These playbooks install GitLab, GitLab Runner and Docker .
* GitLab is used as VCS and CI
* Docker is used to handle the integration server environments.

3. Connect to GitLab

Open http://192.168.33.10/gitlab in your browser. <br>
It will be asked to provide a password (refered as $YOUR_PASSWORD later) for the root credentials.
To further login with root the credentials are: <br>
Login: root <br>
Password: $YOUR_PASSWORD <br>

**Notes :**
* Register for a new user in gitlab : Upon starting the service up yet another user is requested to be created. 
Keep the credentials of this new user, as you'll need it for creating repositories.

* In case you need to reset the password of a GitLab user follow the instructions 
given in this [link](https://docs.gitlab.com/ee/security/reset_root_password.html)


## Use Gitlab(Version Control System)
The purpose of the this jon to make use of GitLab as a VCS.
1. Create SEEProduct project (in GitLab a project is a repository).<br>
Follow the instructions to create the remote and local repositories.<br>
2. do NOT use the GitLab's root user to create the repository and to push to it.You should use your new created user id and password.<br>
 use the project placed at:<br>
`~/<git_root_folder>/SEE_Devops/imagegallery`

3. Commit and push to your created remote repository.
 **Notes :**
 --As you created repository before follow the existing folder option to push the project into SSEProduct (in GitLab a project is a repository)
 
### Automate build
The objective of this stage is to configure the GitLab project such that any update can change on to romote repository and the build process is started automatically.

## Gitlab Runner Configure
#### Install Gitlab Runner

1. Make sure that you are in the working directory :
`cd ~/<git_root_folder>/SEE_Devops/pipeline/serverintegration`

2. Now enter into vagrant by this ssh command :
`sudo vagrant ssh`

#### Register the Runner to Build imagegallery project

1. Firstly, register the gilab-runner following command:
`sudo gitlab-runner register`

2. Enter the requested information as follows:	
For GitLab instance URL enter:<br>	
`http://192.168.33.10/gitlab/`

3. Need to take gitlab-ci token to enter the generated token.<br>
`Example: cy67fgsgskejlks89`

4. For a description for the runner enter:<br>
`[serverintegration] docker`

5. For the gitlab-ci tags for this runner enter:<br>
`tobuild`

6. For the executor enter:<br>
`docker`

7. Enter the Docker image (eg. ruby:2.1) enter:<br>
`alpine:latest`

8. Then Restart the runner:
`sudo gitlab-runner restart`

**Congratulation and automatic builod process is done if you followed avobe procedure.**

	
## Step 2 : Configure Stage Server environment

1. Again Go to working directory: 
`cd ~/<git_root_folder>/SEE_Devops/pipeline/ServerStage`

2. To create stage environment, run vagrant as VM .
`sudo vagrant up`

-- If everything is ok you will see at the end of the output:
`default : Done`

**Warning and Solution :** If you see the tomcat server installing error( that can be happen for update tomcat version) just edit the following file in the specific line.Ohterwise ignore the warning.	
`setup-tomcat.sh`
 in line : `curl -o apache-tomcat-9.0.40.tar.gz https://downloads.apache.org/tomcat/tomcat-9/v9.0.40/bin//apache-tomcat-9.0.40.tar.gz`
 
3. Enter into vagrant environment of stage server:
`sudo vagrant ssh`

4. Run the Database script by following this command: 
`mysql -u root -p12345678 < /vagrant_scripts/gallery.sql`

**Notes :** 
To check the database just go to 
```
mysql -u root -p
show databases;
```
	
5. Check Tomcat installation and configuration. 
Open a browser, and try to access to these URLs:
```
 http://192.168.33.17:8080
 http://192.168.33.17:8080/manager/html
```

**Notes**:
* User and password are the same: "admin".
* In case these URLs cannot be reached, then try to fix it by restarting tomcat:
	
```sudo /opt/tomcat/bin/shutdown.sh	
sudo /opt/tomcat/bin/startup.sh
```
#### Register the Runner for deploying to stage server

1. Firstly, register the gilab-runner following command:
`sudo gitlab-runner register`

2. Enter the requested information as follows:	
For GitLab instance URL enter:<br>	
`http://192.168.33.10/gitlab/`

3. Need to take gitlab-ci token to enter the generated token.<br>
`Example: cy67fgsgskejlks89`

4. For a description for the runner enter:<br>
`shell`

5. For the gitlab-ci tags for this runner enter:<br>
`deploytostage`

6. For the executor enter:<br>
`shell`


7. Then Restart the runner:
`sudo gitlab-runner restart`

8. Apply sudo permissions to the gitlab-runner

```
sudo usermod -a -G sudo gitlab-runner
sudo visudo
```
9. Now add the following to the down of the file:

```
gitlab-runner ALL=(ALL) NOPASSWD: ALL
```
Then save and exit (Ctl+X -> y)

10. Then Restart the staging environment

```
exit
sudo vagrant reload
```

**Note**: To check the pipeline is automatically started or not : check in the settings of 
the project if "Auto DevOps" is selected.
To access to these settings, go to "Settings" -> "CI/CD" -> "Auto DevOps".

11. Go to the working directory again : 
`cd ~/<git_root_folder>/SEE_Devops/imagegallery`

modify add a new line to end of the update.txt file  
Then commit and push file to repository

After few seconds Have a look on the CI/CD -> Pipelines of the project.

12. After completing the job check the product : 

```
http://192.168.33.17:8080/imagegallery/
```

### Congratualtion Stage server is running

 
## Step 3 : Configure Production Server environment

1. Again Go to working directory: 
`cd ~/<git_root_folder>/SEE_Devops/pipeline/ServerfinalProduction`

2. To create stage environment, run vagrant as VM .
`sudo vagrant up`

-- If everything is ok you will see at the end of the output:
`default : Done`

**Warning and Solution :** If you see the tomcat server installing error( that can be happen for update tomcat version) just edit the following file in the specific line.Ohterwise ignore the warning.	
`setup-tomcat.sh`
 in line : `curl -o apache-tomcat-9.0.40.tar.gz https://downloads.apache.org/tomcat/tomcat-9/v9.0.40/bin//apache-tomcat-9.0.40.tar.gz`
 
3. Enter into vagrant environment of stage server:
`sudo vagrant ssh`

4. Run the Database script by following this command: 
`mysql -u root -p12345678 < /vagrant_scripts/gallery.sql`

**Notes :** 
To check the database just go to 
```
mysql -u root -p
show databases;
```
If Successfully done, Database name gallery is available.
	
5. Check Tomcat installation and configuration. 
Open a browser, and try to access to these URLs:
```
 http://192.168.33.18:8080
 http://192.168.33.18:8080/manager/html
```

**Notes**:
* User and password are the same: "admin".
* In case these URLs cannot be reached, then try to fix it by restarting tomcat:
	
```sudo /opt/tomcat/bin/shutdown.sh	
sudo /opt/tomcat/bin/startup.sh
```
#### Register the Runner for deploying to stage server

1. Firstly, register the gilab-runner following command:
`sudo gitlab-runner register`

2. Enter the requested information as follows:	
For GitLab instance URL enter:<br>	
`http://192.168.33.10/gitlab/`

3. Need to take gitlab-ci token to enter the generated token.<br>
`Example: cy67fgsgskejlks89`

4. For a description for the runner enter:<br>
`shell`

5. For the gitlab-ci tags for this runner enter:<br>
`deploytoproduction`

6. For the executor enter:<br>
`shell`


7. Then Restart the runner:
`sudo gitlab-runner restart`

8. Apply sudo permissions to the gitlab-runner

```
sudo usermod -a -G sudo gitlab-runner
sudo visudo
```
9. Now add the following to the down of the file:

```
gitlab-runner ALL=(ALL) NOPASSWD: ALL
```
Then save and exit (Ctl+X -> y)

10. Then Restart the staging environment

```
exit
sudo vagrant reload
```

**Note**: To check the pipeline is automatically started or not : check in the settings of 
the project if "Auto DevOps" is selected.
To access to these settings, go to "Settings" -> "CI/CD" -> "Auto DevOps".

11. Go to the working directory again : 
`cd ~/<git_root_folder>/SEE_Devops/imagegallery`

modify add a new line to end of the update.txt file  
Then commit and push file to repository

After few seconds Have a look on the CI/CD -> Pipelines of the project.

12. After completing the job check the product : 

```
http://192.168.33.18:8080/imagegallery/
```

### Congratualtion production server is running



