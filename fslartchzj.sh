#!/bin/bash
#Credits:
# Immensely inspired by "Damiano Verzulli"'s answer on https://serverfault.com/questions/696554/creating-a-grow-on-demand-encrypted-volume-with-luks?newreg=97523e0057a84e468fcf58ccb078708a

def=$(tput sgr0);bol=$(tput bold);red=$(tput setaf 1;tput bold);gre=$(tput setaf 2;tput bold);yel=$(tput setaf 3;tput bold);blu=$(tput setaf 4;tput bold);mag=$(tput setaf 5;tput bold);cya=$(tput setaf 6;tput bold)

if [[ "$(whoami)" != "root" ]]; then # check that we are root
	echo "$red Sorry, must be root to do this$def"
	exit 1
fi

for i in losetup cryptsetup; do # check for dependencies
	if [[ "$(command -v $i)" = "" ]]; then
		echo "$red $i is required, please install and retry$def"
		exit 2
	fi
done

function f_stop_test {
echo "did it work?"
read testanswer
if [[ "$testanswer" != "y"  ]]; then
	exit 3
fi
}

function f_create_safe { # used to create a safe file
echo "$mag If you screw one of the questions, just hit ^C$def"
echo "$yel what shall be the safe's name?$def"
echo "Hint: help yourself and avoid spaces and special characters."
read sname
echo "$yel MAX space allocatable to safe? (in Gb)$def"
read smaxsize
echo "$yel Initiating state with blortchjz - COPY YOUR PASSWORD, IT WILL BE ASKED A COUPLE OF TIMES IN THE NEXT STEPS!!!$def"
source blortchzj.sh 200
echo "$red Starting safe creation in 5 seconds, now is still time to press ^C$def"
sleep 5
echo "$red now is too late - if you screwed up, wait for completion and then delete safe through the menu$def"
dd of=$sname.img bs=1G count=0 seek=$smaxsize
mkdir $sname
echo "$(cryptsetup --version;losetup --version)">$sname.info
sloop="$(losetup -f)"
losetup $sloop $sname.img
sleep 2 && echo "step 1/6 complete"
cryptsetup -y luksFormat $sloop
sleep 2 && echo "step 2/6 complete"
cryptsetup luksOpen $sloop $sname
sleep 2 && echo "step 3/6 complete"
mkfs.ext4 /dev/mapper/$sname
sleep 2 && echo "step 4/6 complete"
cryptsetup luksClose /dev/mapper/$sname
sleep 2 && echo "step 5/6 complete"
losetup -d $sloop
sleep 2 && echo "$gre Safe $sname: Initialisation complete$def"
}

function f_open_safe { # used to mount a safe file
echo "$yel get your password with blortchjz - COPY YOUR PASSWORD, IT WILL BE ASKED IN THE NEXT STEP!$def"
source blortchzj.sh 200
echo "$gre Please tell me the name of the safe you would like to use$def"
ls -d */|sed 's/\///'
read sname
sloop="$(losetup -f)"
losetup $sloop $sname.img
cryptsetup luksOpen $sloop $sname && sleep 3 && echo "step 1/2 complete"
mount /dev/mapper/$sname $sname && sleep 3 && echo "$gre Safe mount complete$def"
}

function f_close_safe { #used to unmount a safe file - can be called with $sname as parameter
if [[ "$1" = "" ]]; then
	echo "$gre Which safe would you like to close?$def"
	ls -d */|sed 's/\///'
	read sname
fi
if [[ "$(df|grep $sname)" != "" ]]; then
	umount /dev/mapper/$sname && sleep 2
fi
if [[ -f /dev/mapper/$sname ]]; then
	cryptsetup luksClose /dev/mapper/$sname && sleep 2
fi
losetupstate="$(losetup -l|grep $sname|cut -f1 -d' ')"
if [[ "$losetupstate" != "" ]]; then
	losetup -d $losetupstate && sleep 2
fi
echo "$gre Safe $sname has been closed safely"
}

function f_delete_safe { #used to delete a safe file
echo "$gre Which safe would you like to delete?$def"
ls -d */|sed 's/\///'
read sname
echo "delete safe $sname? say YES to confirm"
read delanswer
if [[ "$delanswer" = "YES"  ]]; then
	f_close_safe $sname && rm -Rf $sname.* $sname && echo "$gre Safe $sname has been deleted"
fi
delanswer=""
}

function m_main { # Main Menu
while [ 1 ]
do
	echo "$cya It is recomended getting familiar to blortchzj before securing important files here$def"
	PS3="$gre Choose a number: $def"
	select choix in "create_safe" "open_safe" "close_safe" "delete_safe" "Quit"
	do
		echo " ";echo "####################################";echo " "
		break
	done
	case $choix in
		create_safe) 	f_create_safe ;;
		open_safe)	f_open_safe ;;
		close_safe)	f_close_safe ;;
		delete_safe)	f_delete_safe ;;
		Quit)		echo bye;exit ;;
		*)		echo "Same player shoot again" ;;
	esac
done
}

m_main
