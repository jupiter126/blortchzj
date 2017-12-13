#!/bin/bash
# default password length is 19 - call app with a number as parameter to override
plength=19
pname=$(echo "$0"|sed -e 's/.sh//' -e 's\./\\')
def=$(tput sgr0);bol=$(tput bold);red=$(tput setaf 1;tput bold);gre=$(tput setaf 2;tput bold);yel=$(tput setaf 3;tput bold);blu=$(tput setaf 4;tput bold);mag=$(tput setaf 5;tput bold);cya=$(tput setaf 6;tput bold)
echo "$yel oh no! my name is $pname, please rename me for enthropy's sake!$def"
echo "$gre Please tell me my new name:$def"
read pname
if [[ "$1" != "" ]]; then
	re='^[0-9]+$'
	if ! [[ $1 =~ $re ]] ; then
		echo "error param is not a number: Not a number" >&2; exit 1
	else
		plength="$1"
	fi
fi
ppass="$pname"
# Feed stuff to app to initialise
echo "$gre Hello, my name is $pname, tell me some stuff$def"
read panswer
if [[ "$panswer" = "" ]]; then
	echo "No text, no pass..."
	exit 2
fi
ppass="$ppass-$panswer"
echo "$bol Once done, press enter on a blank line to go to next step$def"
while [[ "$panswer" != "" ]]; do
	echo "$gre Anything more to tell me?$def"
	read panswer
	ppass="$ppass-$panswer"
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
		echo "$red $(echo $pppasss|md5sum|sha512sum|base64|head -c$plength)$def"
		echo " "
	fi
done
clear
echo "$red For security concerns, please close this window (someone could scroll up)$def"
echo " "
echo "$gre For security concerns, please close this window (someone could scroll up)$def"
echo " "
echo "$yel For security concerns, please close this window (someone could scroll up)$def"
