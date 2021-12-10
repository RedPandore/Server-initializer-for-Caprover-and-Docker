#!/bin/sh

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}You are connected to you'r VPS${NC}"
echo -e "${RED}The operation will take some time, please be patient. ${NC}"
echo -e "${GREEN}Go make yourself a cup of coffee to wait, we doesn't need you anymore. ${NC}"

echo -e "${BLUE}Updating ...${NC}"
sudo apt update &>/dev/null
echo -e "${GREEN}Updating done !${NC}"
echo -e "${BLUE}Upgrading ...${NC}"
sudo apt upgrade -y &>/dev/null
echo -e "${BLUE}Upgrading done !${NC}"
sudo ufw allow 80,443,3000,996,7946,4789,2377/tcp
sudo ufw allow 7946,4789,2377/udp
echo -e "${BLUE}__________---------- Remove old installation ----------__________${NC}"
sudo apt-get remove docker docker-engine docker.io containerd runc -y
echo -e "${BLUE}__________---------- Done ----------__________${NC}"
echo -e "${BLUE}__________---------- Install dependency ----------__________${NC}"
sudo apt-get install -y ca-certificates -y curl -y gnupg -y lsb-release -y
echo -e "${BLUE}__________---------- Done ----------__________${NC}"
echo -e "${BLUE}__________---------- Download Docker ----------__________${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg  --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo -e "${BLUE}__________---------- Done ----------__________${NC}"
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get install docker-ce docker-ce-cli containerd.io -y &>/dev/null


echo -e "${GREEN}__________---------- Docker installed ----------__________${NC}"

echo -e "${BLUE}__________---------- Install CapRover ----------__________${NC}"

docker run -p 80:80 -p 443:443 -p 3000:3000 -v /var/run/docker.sock:/var/run/docker.sock -v /captain:/captain caprover/caprover

echo -e "${GREEN}__________---------- CapRover installed ----------__________${NC}"

echo -e "${BLUE}__________---------- Cleaning ----------__________${NC}"
sudo apt-get autoremove -y &>/dev/null
echo -e "${GREEN}__________---------- Done ! ----------__________${NC}"


echo -e "${GREEN} You can now access to http://[IP_OF_YOUR_SERVER]:3000 with password : captain42 ${RED}/!\ Don't modify anything now !!${NC}"
echo -e "${GREEN} Let's setup you'r caprover instance with caprover CLI by using 'caprover serversetup' on you'r local computer.${NC}"
