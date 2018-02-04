#!/bin/bash
while true; do
	batterystate=$(upower -i /org/freedesktop/UPower/devices/ups_hiddev0 |grep percentage|cut -f15 -d" "|cut -f1 -d%)
	#echo "Battery is at $batterystate"
	if [[ "$batterystate" -gt "0" ]] && [[ "$batterystate" -lt "101" ]]; then
		if [[ "$batterystate" -lt "60" ]]; then
			echo "Battery low, initiating shutdown procedure"
			qvm-run vault "cd /home/user/blortchzj/ && sudo ./fslartchzj.sh closeall"
			qvm-shutdown --all --wait --exclude sys-net --exclude sys-firewall
			qvm-shutdown --all --wait
			shutdown
		else
			echo "Battery charge OK: $batterystate"
		fi
	else
		echo "battery script broken"
	fi
	sleep 60
done
