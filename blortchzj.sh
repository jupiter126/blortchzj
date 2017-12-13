#!/bin/bash
# default password length is 19 - call app with a number as parameter to override
plength=19
pname=$(echo "$0"|sed -e 's/.sh//' -e 's\./\\')
echo "oh no! my name is $pname, please rename me for enthropy's sake!"
echo "please tell me my new name:"
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
echo "Hello, my name is $pname, tell me some stuff"
read panswer
if [[ "$panswer" = "" ]]; then
	echo "No text, no pass..."
	exit 2
fi
ppass="$ppass-$panswer"
while [[ "$panswer" != "" ]]; do
	echo "Anything more to tell me? (once done, press enter on a blank line to go to next step)"
	read panswer
	ppass="$ppass-$panswer"
done
panswer="lol"
#retrieve your passwords
echo "I hope I know enough, now I'll give you passwords"
while [[ "$panswer" != "" ]]; do
	echo "What pass would you like to know? (once done, press enter on a blank line to exit script)"
	read panswer
	if [[ "$panswer" != ""  ]]; then
		pppasss="$ppass-$panswer"
		echo "$pppasss"|md5sum|sha512sum|base64|head -c$plength
		echo " "
	fi
done
