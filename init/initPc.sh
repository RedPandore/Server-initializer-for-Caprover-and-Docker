#!/bin/sh
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

while true; do
    read -r -p "$(echo -e ${BLUE}"Did you want to configure you local machine ? ["${GREEN}"Y"${BLUE}"/"${RED}"N"${BLUE}"]" ${NC})" input
    case $input in
    [yY][eE][sS] | [yY])
        clear
        echo -e "${GREEN}Continue${NC}"
        echo -e "${BLUE}Configuring your local machine...${NC}"
        echo -e "${BLUE}Updating ...${NC}"
        echo -e "${RED}This might take time, please be patient${NC}"
        sudo apt-get update -y 
        sudo apt-get upgrade -y 
        echo -e "${GREEN}DONE${NC}"
        sleep 2
        echo -e "${BLUE}Installing Caprover...${NC}"
        npm install -g caprover -y &>/dev/null
        echo -e "${GREEN}DONE${NC}"
        sleep 2
        clear
        while true; do
            read -r -p "$(echo -e ${BLUE}"You caprover instance is already configured ? ["${GREEN}"Y"${BLUE}"/"${RED}"N"${BLUE}"]" ${NC})" input
            case $input in
            [yY][eE][sS] | [yY])
                clear
                echo -e "${BLUE}Launching caprover login ${NC}"
                caprover login
                echo -e "${GREEN}DONE${NC}"
                break
                ;;
            [nN][oO] | [nN])
                echo -e "${BLUE}Launching caprover Setup ${NC}"
                echo -e "${RED}Note: It will not be possible to carry through with the 'caprover serversetup' if you've already forced https on your CapRover instance.${NC}"
                sleep 2
                echo -e "${RED}Note: In such case go straight to logging in with the caprover login command. To change the password go to the settings menu in the app.${NC}"
                sleep 2
                echo -e "${BLUE}You can get help for this part here => https://caprover.com/docs/get-started.html#step-2-connect-root-domain${NC}"
                sleep 5
                caprover serversetup
                echo -e "${GREEN}DONE${NC}"
                sleep 2
                echo -e "${GREEN}You'r server and Local machine has configured !${NC}"
                echo -e "${BLUE}You can get more information about caprover here => https://caprover.com/docs/get-started.html#step-5-deploy-the-test-app ${NC}"
                echo -e "${GREEN} GoodBye !${NC}"
                break
                ;;
            *)
                echo -e "${RED}Please enter a valid option${NC}"
                ;;
            esac
        done

        ;;
    [nN][oO] | [nN])
        echo -e "${RED}Quitting...${NC}"
        break
        ;;
    *)
        echo -e "${RED}Please enter a valid option${NC}"
        ;;
    esac
done
