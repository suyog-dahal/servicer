#!/usr/bin/env bash

usage='Usage: \n servicer [ service argument ] {-h}\n'
invalid='\n not a valid option\n'
argument='\n Please use -h option for help\n'

# use the getopts command to set options for the scripts

while getopts "hs:" option
	do
		case "${option}" in
			s ) service="$OPTARG";;
			h ) echo -e "$usage"
			   exit 1 
			;;
			* ) echo -e "$invalid"
			   exit 1
			;;
		esac
	done

#check whether the service has parameters or not

if [[ ${#service} -lt 0 ]]
then 	
	echo -e "$argument" && exit 1
fi

# check whether the service is running or not
 
status=$(pgrep ${service})

#if [[ ${status} -gt 0 ]]
#then
#	echo -e "${service} is running" && exit 0
#else
#	echo -e "${service} is not running" && exit 1
#fi

#setting counter

counter=0

while [[ "${status}" -gt 0 ]]
do
counter=$((counter+1))

# shows the echo statement once then runs the echo statement in the background

	if [[ ${counter} = 1 ]]
	then
		echo -e "${service} is running"
	 
	else 
		echo -e "${service} is running" > /dev/null
	fi
done


echo -e "${service} is not running"
