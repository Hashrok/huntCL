#!/bin/bash

#COLORS
red="\033[1;31m"
green="\033[1;32m"
white="\033[1;37m"
yellow="\033[1;33m"

function menu() {

  echo  -e "$green"                                                         
  echo  "    __                __  ________ "
  echo  "   / /_  __  ______  / /_/ ____/ / "
  echo  "  / __ \/ / / / __ \/ __/ /   / /  "
  echo  " / / / / /_/ / / / / /_/ /___/ /___"
  echo  "/_/ /_/\__,_/_/ /_/\__/\____/_____/"
  echo ""
  echo -e "$white"
  read -p "[+] Enter list path : " list
  read -p "[+] Enter specific inurl : " filename
  read -p "[+] Enter specific text : " text
  echo ""
  
  for site in $(cat $list); 
do
	if [[ $(curl -s -m 3 -A "Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0" "${site}/$filename" -w %{http_code} -o /dev/null ) =~ '403' ]]; then  
  	echo "" 
	fi

    if [[ $(curl --connect-timeout 3 --max-time 3 -kLs "${site}/$filename" ) =~ "$text" ]]; then
		echo -e "$green""[+] Your search options have been detected on this server " "$white" 
    echo -e "${site}" | tee -a ./database/DB-$list
    echo ""
	else :
	fi
    
done

clear
echo -e "[+]$white Information saved in the $yellow/database$white folder"
echo -e "[+] Hunt successfully completed..."

}
clear
menu
