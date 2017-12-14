#!/bin/bash
# default password length is 19 - call app with a number as parameter to override
plength=19
pname=$(echo "$0"|sed -e 's/.sh//' -e 's\./\\')
def=$(tput sgr0);bol=$(tput bold);red=$(tput setaf 1;tput bold);gre=$(tput setaf 2;tput bold);yel=$(tput setaf 3;tput bold);blu=$(tput setaf 4;tput bold);mag=$(tput setaf 5;tput bold);cya=$(tput setaf 6;tput bold)
echo "$yel oh no! my name is $pname, please rename me for enthropy's sake!$def"
echo "$gre Please tell me my new name:$def"
read pname
if [[ "$1" != "" ]]; then #first param (optional) is pass length
	re='^[0-9]+$'
	if ! [[ $1 =~ $re ]] ; then
		echo "error param is not a number: Not a number" >&2; exit 1
	else
		plength="$1"
	fi
fi
if [[ "$2" = "1" ]]; then #second param (optional) enables "script mode" - requires 1st param to be set...
	scriptmode="1"
else
	scriptmode="0"
fi
ppass="$pname"
# Feed stuff to app to initialise
echo "$gre Hello, my name is $pname, tell me some stuff$def"
read panswer
if [[ "$panswer" = "" ]]; then
	echo "No text, no pass..."
	exit 2
fi
ppass=$(echo "$ppass-$panswer"|sha512sum|base64|tr -d '\r\n')
echo "$bol Once done, press enter on a blank line to go to next step$def"
while [[ "$panswer" != "" ]]; do
	echo "$gre Anything more to tell me?$def"
	read panswer
	ppass=$(echo "$ppass-$panswer"|sha512sum|base64|tr -d '\r\n')
#echo $ppass
done
panswer="lol"
#retrieve your passwords
echo "I hope I know enough, now I'll give you passwords"
echo "$bol Once done, press enter on a blank line to exit script$def"
while [[ "$panswer" != "" ]]; do
	echo "$gre What pass would you like to know?$def"
	read panswer
	if [[ "$panswer" != ""  ]]; then
		pppasss="$ppass-$panswer"
		echo "$red $(echo $pppasss|sha512sum|base64|head -c$plength|tr -d '\r\n')$def"
		echo " "
	fi
	if [[ "$scriptmode" = "1" ]]; then
		panswer=""
	fi
done
if [[ "$scriptmode" != "1" ]]; then
	clear
	echo "$red For security concerns, please close this window (someone could scroll up)$def"
	echo " "
	echo "$gre For security concerns, please close this window (someone could scroll up)$def"
	echo " "
	echo "$yel For security concerns, please close this window (someone could scroll up)$def"
fi
