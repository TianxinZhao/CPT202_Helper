#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo -e " \e[32m
 #####     ######     #######     #####       ###       #####  
#     #    #     #       #       #     #     #   #     #     # 
#          #     #       #             #    #     #          # 
#          ######        #        #####     #     #     #####  
#          #             #       #          #     #    #       
#     #    #             #       #           #   #     #       
 #####     #             #       #######      ###      ####### 
\e[0m"    
echo -e "\e[32m==============================================================\e[0m"
echo -e "\e[32mAuto Deployment Script for CPT202, AY2024\e[0m"
echo -e "\e[32m
Author:         Tianxin Zhao
Email:          Tianxin.Zhao21@student.xjtlu.edu.cn
Version:        2.0
Release Time:   2024/4/18
Release page:   http://deploy.cpt202.website
Maintain page:  https://github.com/ZTX1836255060/CPT202_Helper
Target:         Nginx, Mysql, Java21 and Docker with Portainer

Please note that Portainer may use ports 8000 and 9000, If you want to use it to manage Docker, please ask the teacher to open these ports OR modify the port mapping relationship manually.
Please note that you can also use this script to automatically deploy and maintain your APP to a Docker container (assuming you have exported the JAR).
All other marterial could be found on LearningMall, release or maintain page.\e[0m"
echo -e "\e[32m==============================================================\e[0m"
echo -e "\e[32m-> Started.\e[0m"
echo -e "\e[32m==============================================================\e[0m"

sudo apt-get update

# Install Nginx 
echo -e "\e[34m==============================================================\e[0m"
echo -e "\e[34m-> Installing Nginx...\e[0m"
echo -e "\e[34m==============================================================\e[0m"
sudo apt-get install -y nginx

# Test Nginx
if systemctl status nginx &> /dev/null; then
	sudo systemctl start nginx
	sudo systemctl enable nginx
	echo -e "\e[34m==============================================================\e[0m"
	echo -e "\e[34m-> Nginx installation successful.\e[0m"
	echo -e "\e[34m==============================================================\e[0m"
else
	echo -e "\e[31m==============================================================\e[0m"
	echo -e "\e[31m-> Nginx installation failed, Please check the error log for details.\e[0m"
	echo -e "\e[31m==============================================================\e[0m"
fi

# Install Java21
echo -e "\e[34m==============================================================\e[0m"
echo -e "\e[34m-> Installing Java21...\e[0m"
echo -e "\e[34m==============================================================\e[0m"
sudo apt install openjdk-21-jdk -y

# Test Java
if java -version 2>&1 >/dev/null; then
	echo -e "\e[34m==============================================================\e[0m"
	echo -e "\e[34m-> Java installation successful.\e[0m"
	echo -e "\e[34m==============================================================\e[0m"
else
	echo -e "\e[31m==============================================================\e[0m"
	echo -e "\e[31m-> Java installation failed, Please check the error log for details.\e[0m"
	echo -e "\e[31m==============================================================\e[0m"
fi

# Install MySQL
echo -e "\e[34m==============================================================\e[0m"
echo -e "\e[34m-> Installing Java21...\e[0m"
echo -e "\e[34m==============================================================\e[0m"
sudo apt-get install -y mysql-server

# Test MySQL
if systemctl status mysql &> /dev/null; then
    echo -e "\e[34m==============================================================\e[0m"
	echo -e "\e[34m-> MySQL installation successful.\e[0m"
	echo -e "\e[34m==============================================================\e[0m"
else
   	echo -e "\e[31m==============================================================\e[0m"
	echo -e "\e[31m-> MySQL installation failed, Please check the error log for details.\e[0m"
	echo -e "\e[31m==============================================================\e[0m"
fi

# Install Docker
echo -e "\e[34m==============================================================\e[0m"
echo -e "\e[34m-> Installing Docker...\e[0m"
echo -e "\e[34m==============================================================\e[0m"
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "" | sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Test Docker
if sudo docker run hello-world &> /dev/null; then
    echo -e "\e[34m==============================================================\e[0m"
	echo -e "\e[34m-> Deploying Portainer...\e[0m"
	echo -e "\e[34m-> You may find it on http://Your_Server_IP:8000\e[0m"
	echo -e "\e[34m==============================================================\e[0m"
	# Install Portainer
    sudo docker run -d -p 8000:8000 -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
else
   	echo -e "\e[31m==============================================================\e[0m"
	echo -e "\e[31m-> Docker installation failed, Please check the error log for details.\e[0m"
	echo -e "\e[31m==============================================================\e[0m"
fi

# Config MySQL
echo -e "\e[33m==============================================================\e[0m"
echo -e "\e[33m-> (It is not a error message)\e[0m"
echo -e "\e[33m-> Please manually configure MySQL...\e[0m"
echo -e "\e[33m==============================================================\e[0m"
sudo mysql_secure_installation

# Completed 
echo -e " \e[32m
 #####     ######     #######     #####       ###       #####  
#     #    #     #       #       #     #     #   #     #     # 
#          #     #       #             #    #     #          # 
#          ######        #        #####     #     #     #####  
#          #             #       #          #     #    #       
#     #    #             #       #           #   #     #       
 #####     #             #       #######      ###      ####### 
\e[0m"    

echo -e "\e[32m==============================================================\e[0m"
echo -e "\e[32m-> Completed.\e[0m"
echo -e "\e[32m==============================================================\e[0m"
echo -e "\e[32mAuto Deployment Script for CPT202, AY2024\e[0m"
echo -e "\e[32m
Author:         Tianxin Zhao
Email:          Tianxin.Zhao21@student.xjtlu.edu.cn
Version:        2.0
Release Time:   2024/4/18
Release page:   http://deploy.cpt202.website
Maintain page:  https://github.com/ZTX1836255060/CPT202_Helper
Target:         Nginx, Mysql, Java21 and Docker with Portainer

Please note that Portainer may use ports 8000 and 9000, If you want to use it to manage Docker, please ask the teacher to open these ports OR modify the port mapping relationship manually.
Please note that you can also use this script to automatically deploy and maintain your APP to a Docker container (assuming you have exported the JAR).
All other marterial could be found on LearningMall, release or maintain page.\e[0m"
echo -e "\e[32m==============================================================\e[0m"
