#!/bin/sh

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}You are connected to you'r VPS${NC}"
echo -e "${RED}The operation will take some time, please be patient. ${NC}"
echo -e "${GREEN}Go make yourself a cup of coffee to wait, we doesn't need you anymore. ${NC}"
sleep 5
echo -e "${BLUE}Updating ...${NC}"
sleep 2
sudo apt update && sudo apt upgrade -y 
ufw allow 80,443,3000,996,7946,4789,2377/tcp; ufw allow 7946,4789,2377/udp;
clear
  echo -e "${BLUE}__________---------- Install Docker ----------__________${NC}"
  sleep 5
sudo apt-get remove docker docker-engine docker.io containerd runc -y

sudo apt-get install -y\
    ca-certificates -y\
    curl -y\
    gnupg -y\
    lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get install docker-ce docker-ce-cli containerd.io
clear
echo -e "${GREEN}__________---------- Docker installed ----------__________${NC}"
sleep 5
echo -e "${BLUE}__________---------- Install CapRover ----------__________${NC}"
sleep 5
docker run -p 80:80 -p 443:443 -p 3000:3000 -v /var/run/docker.sock:/var/run/docker.sock -v /captain:/captain caprover/caprover
clear
echo -e "${GREEN}__________---------- CapRover installed ----------__________${NC}"
sleep 10
sudo apt-get autoremove -y
clear
echo -e "${GREEN} You can now access to http://[IP_OF_YOUR_SERVER]:3000 with password : captain42 ${RED}/!\ Don't modify anything now !!${NC}"
echo -e "${GREEN} Let's setup you'r caprover instance with caprover CLI by using 'caprover serversetup' on you'r local computer.${NC}"