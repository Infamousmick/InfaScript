#!/bin/bash
exit_a() {
    printf "\n${RESET}${txtbgred}Do you want to exit? (Y/n): ${RESET}\n"
    read -n 1 input
    case $input in
        [yY])
            printf "\n   ${RESET}${RED}${UNDERLINE}Press ENTER to exit ${RESET}\n" 
            read -r a 
            pkill -f InfaScript.sh
            pkill -f AdbCommands.sh
            ;;
        [nN])
            printf "${RED}\nPress \"Enter\" to return to the 'ADB Commands' menu again${RESET}" ; read -r a ; printf "\n%.0s" {1..100} ; clear; start
            ;;
        *)
            printf "\n${RED}[!] Choose a valid option.${RESET}\n"
            read -r a
            exit_a
            ;;
    esac
}

confirm_and_execute() {
    printf "${BLUE}\nAre you sure? (Y/n): "
    read -n 1 confirm_choice
    printf "\n"
    case $confirm_choice in
        [Yy])
            return 0 ;; # Indica che la conferma è stata data correttamente
        [nN])
            printf "${RED}\nPress \"Enter\" to return to the 'ADB Commands' menu again${RESET}" ; read -r a ; printf "\n%.0s" {1..100} ; clear; start
            ;;
        *)
            printf "${RED}[!] Choose a valid option.${RESET}\n"
            read -r a 
            confirm_and_execute
            ;;
    esac
    return 1 # Indica che la conferma non è stata data correttamente
}

start() {
    printf "\n%.0s" {1..100} ; clear
    printf "\n\n${RESET}    ${BLUE}########## ADB MENU ##########${WHITE}

    ${BOLD_WHITE}Choose what to do?\n${RESET}
    1.  Run adb Preset inside the script
    2.  Reset the value of the Preset adb
    3.  ADB Preset Backup
    ${MAGENTA}4.  Return to Optimizations
    ${MAGENTA}5.  Return to start
    ${RED}6.  Exit\n
    ${RESET}${BLUE}##############################${RESET}${BOLD}\n
    Enter your choice: "
    read -r choice
    case $choice in
        1)
            confirm_and_execute || return
            sh bin/AdbRun.sh
            ;;
        2) 
            confirm_and_execute || return
            sh bin/Adbreset.sh
            ;;
        3)
            confirm_and_execute || return
            sh bin/AdbBackup.sh
            ;;
        4)
           confirm_and_execute || return
            printf "\n   ${RESET}${UNDERLINE}${BOLD}Press ENTER to return to 'Optimizations' menu${RESET}\n"
            read -r a
            exit 0
            ;;
        5)
            confirm_and_execute || return
            printf "\n   ${RESET}${UNDERLINE}${BOLD}Press ENTER to return to Start${RESET}\n"
            read -r a
            bash ${WDIR}/InfaScript.sh
            ;;
        6)
            exit_a
            ;;
        *)  
            printf "\n${RED}[!] Choose a valid option.${RESET}\n"
            read -r a 
            start
            ;;
    esac
}

start 
