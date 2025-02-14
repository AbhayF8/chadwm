#!/usr/bin/bash

interval=0

## Cpu Info
cpu_info() {
	# cpu_load=$(grep -o "^[^ ]*" /proc/loadavg)
	cpu_usage=$(expr 100 - $(top -b -n 1 | grep Cpu | awk '{print $8}'|cut -f 1 -d "."))
	printf "^c#3b414d^ ^b#7ec7a2^ CPU"
	printf "^c#abb2bf^ ^b#353b45^ $cpu_usage%%"
}

## Memory
memory() {
	printf "^c#C678DD^^b#1e222a^   $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g) "
}

## Ethernet
eth() {
	R1=`cat /sys/class/net/e*/statistics/rx_bytes`
	T1=`cat /sys/class/net/e*/statistics/tx_bytes`
	sleep 1
	R2=`cat /sys/class/net/e*/statistics/rx_bytes`
	T2=`cat /sys/class/net/e*/statistics/tx_bytes`
	TBPS=`expr $T2 - $T1`
	RBPS=`expr $R2 - $R1`
	TKBPS=`expr $TBPS / 1024`
	RKBPS=`expr $RBPS / 1024`
	if [[ $RKBPS  -gt 1024 ]]
	then
		downlink="$(expr $RKBPS / 1024) mB"
	else
		downlink="$RKBPS kB"
	fi
	if [[ $TKBPS  -gt 1024 ]]
	then
		uplink="$(expr $TKBPS / 1024) mB"
	else
		uplink="$TKBPS kB"
	fi


	case "$(cat /sys/class/net/e*/operstate 2>/dev/null)" in
		up) printf "^c#3b414d^^b#7aa2f7^  ^d^%s" " ^c#7aa2f7^$downlink | $uplink" ;;
		down) printf "^c#3b414d^^b#E06C75^  ^d^%s" " ^c#E06C75^Disconnected " ;;
	esac
}

## Wi-fi
wlan() {
	R1=`cat /sys/class/net/w*/statistics/rx_bytes`
	T1=`cat /sys/class/net/w*/statistics/tx_bytes`
	sleep 1
	R2=`cat /sys/class/net/w*/statistics/rx_bytes`
	T2=`cat /sys/class/net/w*/statistics/tx_bytes`
	TBPS=`expr $T2 - $T1`
	RBPS=`expr $R2 - $R1`
	TKBPS=`expr $TBPS / 1024`
	RKBPS=`expr $RBPS / 1024`
	if [[ $RKBPS  -gt 1024 ]]
	then
		downlink="$(expr $RKBPS / 1024) mB"
	else
		downlink="$RKBPS kB"
	fi
	if [[ $TKBPS  -gt 1024 ]]
	then
		uplink="$(expr $TKBPS / 1024) mB"
	else
		uplink="$TKBPS kB"
	fi


	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
		up) printf "^c#3b414d^^b#7aa2f7^  ^d^%s" " ^c#7aa2f7^$downlink " ;;
		down) printf "^c#3b414d^^b#E06C75^ 睊 ^d^%s" " ^c#E06C75^Disconnected " ;;
	esac
}

## Time
clock() {
	printf "^c#1e222a^^b#668ee3^  "
	printf "^c#1e222a^^b#7aa2f7^ $(date '+%a, %I:%M %p') "
}

temp() {

	sensor=$(sed 's/000$/°C/' /sys/class/thermal/thermal_zone0/temp)
	printf "^c#abb2bf^ ^b#353b45^ $sensor"
}
## System Update
# updates() {
	# updates=$(checkupdates | wc -l)
#
	# if [ -z "$updates" ]; then
		# printf "^c#98C379^  Updated"
	# else
		# printf "^c#98C379^  $updates"" updates"
	# fi
# }

## Battery Info
battery() {
	BAT=$(sed 's/$//' /sys/class/power_supply/BAT0/capacity)
	AC=$(sed 's/$//' /sys/class/power_supply/BAT0/status)
	# BAT=$(upower -i `upower -e | grep 'BAT'` | grep 'percentage' | cut -d':' -f2 | tr -d '%,[:blank:]')
	# AC=$(upower -i `upower -e | grep 'BAT'` | grep 'state' | cut -d':' -f2 | tr -d '[:blank:]')

	if [[ "$AC" == "Charging" ]]; then
		printf "^c#E49263^  $BAT%%"
	elif [[ "$AC" == "Full" ]] || [[ "$AC" == "Not charging" ]]; then
		printf "^c#E06C75^  Full"
	else
	# if [[ "$AC" == "charging" ]]; then
		# printf "^c#E49263^  $BAT%%"
	# elif [[ "$AC" == "fully-charged" ]]; then
		# printf "^c#E06C75^  Full"
	# else
		if [[ ("$BAT" -ge "0") && ("$BAT" -le "20") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		elif [[ ("$BAT" -ge "20") && ("$BAT" -le "40") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		elif [[ ("$BAT" -ge "40") && ("$BAT" -le "60") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		elif [[ ("$BAT" -ge "60") && ("$BAT" -le "80") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		elif [[ ("$BAT" -ge "80") && ("$BAT" -le "100") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		fi
	fi
}

## Brightness
brightness() {
	LIGHT=$(printf "%.0f\n" `light -G`)

	if [[ ("$LIGHT" -ge "0") && ("$LIGHT" -le "25") ]]; then
		printf "^c#56B6C2^  $LIGHT%%"
	elif [[ ("$LIGHT" -ge "25") && ("$LIGHT" -le "50") ]]; then
		printf "^c#56B6C2^  $LIGHT%%"
	elif [[ ("$LIGHT" -ge "50") && ("$LIGHT" -le "75") ]]; then
		printf "^c#56B6C2^  $LIGHT%%"
	elif [[ ("$LIGHT" -ge "75") && ("$LIGHT" -le "100") ]]; then
		printf "^c#56B6C2^  $LIGHT%%"
	fi
}

## Main
while true; do
  [ "$interval" == 0 ] || [ $(("$interval" % 3600)) == 0 ] # && updates=$(updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$(battery) $(brightness) $(temp) $(cpu_info) $(memory) $(eth) $(clock)"
done
