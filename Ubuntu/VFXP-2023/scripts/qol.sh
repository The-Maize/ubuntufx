#!/bin/bash
######### Created by Maize @ NanoVFX #########
# You can use this script to auto install software packages you want. To add packages from different locations
# please add the repositories to the repoadd.sh script. use the ADD_EXTRA-README.md to learn how. 
STD_REPO_SOFT="timeshift btop"
QOL_CUST_SOFT="apt-fast"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

#TODO Add option to install from both std repo and cust repo 


install_qol_in_std_repo(){
        
        echo ""
        read -p "SECOND CHANCE PROMPT: Are you sure you wish to install the listed software? " ls_a
        echo "$STD_REPO_SOFT"
        if [ "$ls_a" = "yes" ]; then
            apt install $STD_REPO_SOFT
        else
            echo "Skipping..."
        fi
    return 0
}

install_qol_w_cust_repos(){
    
    echo "Software in the list to install: '$QOL_CUST_SOFT '"
    echo ""

    echo ": SECOND CHANCE PROMPT: If you have edited the qol.sh and repoadd.sh: Type yes to the next question if you have.. "
    echo ""
    read -p "Would you like to add custom ppa's to this install and install software from there as well? " qolcust_a
        
    if [ "$qolcust_a" = "yes" ]; then
        . $SCRIPT_DIR/repoadd.sh
        check_exists
            if [ $? -eq 0 ]; then
                apt install $QOL_CUST_SOFT
            else
            echo "an error occured in qol, or repoadd. Please put in a bug report on Github to have it fixed"
            fi
    else 
        install_qol_in_std_repo
    
    fi
return 0
}

usrchoice(){

    echo "READ CAREFULLY!!!"
    echo "READ CAREFULLY!!!"
    echo "READ CAREFULLY!!!"
    echo ""

    read -p "Do you want to install from custom choices or choice already made in this script? ENTER: CUST for custom and STD for pre selected software: " c_a
    echo " "

    if [ "$c_a" = "CUST" ]; then
        install_qol_w_cust_repos
    else 
        install_qol_in_std_repo
    fi

    return 0

}

usrchoice