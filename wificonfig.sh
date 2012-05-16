#!/bin/sh

### wificonfig.sh v1.0
###
### Usage: # wificonfig <essid> [password]
###
### The Jornada 720 wifi configuration script
### Just the automation of a simple proccess

ask_check ()
{
	echo -n "Check again if it has already connected to $1? (y/n): "
	read check_again < /dev/tty
	
	if [ check_again = "y" ]
	then
		ifconfig eth0 | grep "inet addr"
		ask_check $1
	else
		exit 0
}

if [ $# = 0 ]
then
	echo "Usage: $0 <essid> [password]"
	exit 1
fi

echo "Configuring your device to connect to $1..."

if [ $2 ]
then
	iwconfig eth0 key $2 essid "$1"
else
	iwconfig eth0 essid "$1"
fi

echo -n "Device configured. Check if it has already connected? (y/n): "
read check_again < /dev/tty

if [ check_again = "y" ]
then
	ifconfig eth0 | grep "inet addr"
	ask_check $1
else
	exit 0