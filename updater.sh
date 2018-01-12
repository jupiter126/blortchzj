#!/bin/bash
if [[ "$#" != "4" ]]; then
	echo "Usage is ./updater.sh user host port imagename"
	exit 1
else
	user="$1";host="$2";port="$3";updimg="$(ls $4*.img|cut -f1 -d.)"
	if [[ -f $updimg.img ]] && [[ -f $updimg.img.sha512sum ]]; then
		scp -P $port $updimg.* $user@$host:/home/$user/
		if ssh -p $port $user@$host "sha512sum -c $updimg.img.sha512sum"; then
			echo "update sent successfully"
		else
			echo "failed to send update"
		fi
	else
		echo "img and sha512 files not found"
		exit 2
	fi
fi
