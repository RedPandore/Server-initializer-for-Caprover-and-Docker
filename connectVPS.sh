#!/bin/sh
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Hello, what is the username you use for connect to you'r vps?${NC}"
read varname
echo -e "${BLUE}What is the adress of your vps?${NC}"
read varip

echo -e "${BLUE}You want to connect to your vps with the following information:${NC}"
echo -e "${BLUE}Username: ${RED}$varname"
echo -e "${BLUE}IP: ${RED}$varip"
while true; do
    read -r -p "$(echo -e ${BLUE}"Are You Sure? ["${GREEN}"Y"${BLUE}"/"${RED}"n"${BLUE}"]" ${NC})" input

    case $input in
    [yY][eE][sS] | [yY])
        echo -e "${RED}/!\ Stay present to enter your password if you don't have an ssh key /!\ ${NC}"
        echo -e "${BLUE}Connecting...${NC}"
        scp init/initVps.sh $varname@$varip:~/
        echo -e "${GREEN}File transfered!${NC}"
        echo -e "${BLUE}Connecting...${NC}"
        ssh $varname@$varip "sudo chmod +x initVps.sh && bash initVps.sh"
        break
        ;;
    [nN][oO] | [nN])
        while true; do
            read -r -p "$(echo -e ${BLUE}"Retry or Quit? ["${GREEN}"R"${BLUE}"/"${RED}"Q"${BLUE}"]" ${NC})" input
            case $input in
            [rR][eE][tT][rR][yY] | [rR])
                echo -e "${GREEN}Retrying...${NC}"
                sleep 2
                clear
                exec bash $0
                break
                ;;
            [qQ][uU][iI][tT] | [qQ])
                echo -e "${RED}Quitting...${NC}"
                break
                ;;
            *)
                echo -e "${RED}Please enter a valid option${NC}"
                ;;
            esac
        done

        break
        ;;
    *)
        echo -e "${RED}Please enter a valid option${NC}"
        ;;
    esac
done
