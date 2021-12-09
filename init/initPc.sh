#!/bin/sh
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

while true; do
            read -r -p "$(echo -e ${BLUE}"Did you want to configure you local machine ? ["${GREEN}"Y"${BLUE}"/"${RED}"N"${BLUE}"]" ${NC})" input
            case $input in
            [yY][eE][sS] | [Y])
                echo -e "${GREEN}Continue${NC}"
                echo -e "${BLUE}Configuring your local machine...${NC}"
                echo -e "${BLUE}Updating ...${NC}"
                sudo apt update -y &>/dev/null
                sudo apt upgrade -y &>/dev/null
                echo -e "${GREEN}DONE${NC}"
                echo -e "${BLUE}Installing Caprover...${NC}"
                npm install -g caprover -y &>/dev/null
                echo -e "${GREEN}DONE${NC}"
                echo -e "${BLUE}Launching caprover Setup ${NC}"
                echo -e "${RED}Note: It will not be possible to carry through with the 'caprover serversetup' if you've already forced https on your CapRover instance.${NC}"
                echo -e "${RED}Note: In such case go straight to logging in with the caprover login command. To change the password go to the settings menu in the app.${NC}"
                echo -e "${BLUE}You can get help for this part here => https://caprover.com/docs/get-started.html#step-2-connect-root-domain${NC}"
                caprover serversetup
                echo -e "${GREEN}DONE${NC}"

                echo -e "${GREEN}You'r server and Local machine has configured !${NC}"
                echo -e "${BLUE}You can get more information about caprover here => https://caprover.com/docs/get-started.html#step-5-deploy-the-test-app ${NC}"
                echo -e "${GREEN} GoodBye !${NC}"
                break
                ;;
            [nN][oO]| [nN])
                echo -e "${RED}Quitting...${NC}"
                break
                ;;
            *)
                echo -e "${RED}Please enter a valid option${NC}"
                ;;
            esac
        done
