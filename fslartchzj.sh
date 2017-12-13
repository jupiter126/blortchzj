#!/bin/bash

#source blortchzj.sh 200

function f_create_safe {
dd of=safe.img bs=1G count=0 seek=29
losetup /dev/loop0 safe.img
cryptsetup -y luksFormat /dev/loop0
cryptsetup luksOpen /dev/loop0 secretfs
mkfs.ext4 /dev/mapper/secretfs
}

function f_mount_safe {
cryptsetup luksOpen /dev/loop0 secretfs
mount /dev/mapper/secretfs /mnt/temppp
}

function f_unmount_safe {
umount /dev/mapper/secretfs /mnt/temppp
cryptsetup luksClose /dev/mapper/secretfs
}

function m_main { # Main Menu (displayed if genQL is called without args)
while [ 1 ]
do
	PS3='Choose a number: '
	select choix in "create_safe" "open_safe" "close_safe" "delete_safe" "Quit"
	do
		echo " ";echo "####################################";echo " "
		break
	done
	case $choix in
		create_safe) 	echo create ;;
		open_safe)	echo open ;;
		close_safe)	echo close ;;
		delete_safe)	echo delete ;;
		Quit)		echo bye;exit ;;
		*)		echo "Same player shoot again" ;;
	esac
done
}

