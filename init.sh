#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo -e " \e[34m
 #####     ######     #######     #####       ###       #####  
#     #    #     #       #       #     #     #   #     #     # 
#          #     #       #             #    #     #          # 
#          ######        #        #####     #     #     #####  
#          #             #       #          #     #    #       
#     #    #             #       #           #   #     #       
 #####     #             #       #######      ###      ####### 
\e[0m"    

echo -e "\e[34mStarting the installation of Nginx, MySQL, Docker, and Portainer...\e[0m"

sudo apt-get update

sudo apt-get install -y nginx

if systemctl status nginx &> /dev/null; then
    echo -e "\e[32mNginx installation successful.\e[0m"
else
    echo -e "\e[31mNginx installation failed.\e[0m"
    echo -e "\e[34mPlease check the error log for details.\e[0m"
fi

sudo systemctl start nginx
sudo systemctl enable nginx

sudo apt-get install -y mysql-server

if systemctl status mysql &> /dev/null; then
    echo -e "\e[32mMySQL installation successful.\e[0m"
else
    echo -e "\e[31mMySQL installation failed.\e[0m"
    echo -e "\e[34mPlease check the error log for details.\e[0m"
fi

sudo mysql_secure_installation



# 安装必需的软件包
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# 添加Docker的官方GPG密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 添加Docker的仓库，自动确认
echo "" | sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# 更新软件包列表
sudo apt-get update

# 安装Docker社区版
sudo apt-get install -y docker-ce


if sudo docker run hello-world &> /dev/null; then
    echo -e "\e[32mDocker installation successful.\e[0m"
    sudo docker run -d -p 8000:8000 -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
    echo -e "\e[32mPortainer has been started.\e[0m"
else
    echo -e "\e[31mDocker installation failed.\e[0m"
    echo -e "\e[34mPlease check the error log for details.\e[0m"
fi

echo -e "\e[34mInstallation of Nginx, MySQL, Docker, and Portainer has been completed.\e[0m"
