#!/bin/bash

function display_help()
{
	echo
	./script/echocolor.sh -y "The " -Y "$0 script" -y " runs specified command for specified number of seconds,"
	./script/echocolor.sh -y "then stops the command and exits."
	echo
	./script/echocolor.sh -Y "Syntax:"
	./script/echocolor.sh -y "	$0 [-h] [-d <directory to run command in>] -t <timeout in seconds> -c <command to run>"
	echo
	./script/echocolor.sh -Y "Options:"
	./script/echocolor.sh -y "	h	display usage information"
	./script/echocolor.sh -y "	t	timeout value in seconds"
	./script/echocolor.sh -y "	c	command to run"
	./script/echocolor.sh -y "	d	run command in specified directory"
	echo
	./script/echocolor.sh -Y "Examples:"
	./script/echocolor.sh -y "	   $> $0 -t 10 -c 'my_command'"
	echo
}


function display_error()
{
	./script/echocolor.sh -r "$1"
}


min_expected_arguments=1

if [[ $# -lt $min_expected_arguments ]]
then
	display_error "Error: Expected at least $min_expected_arguments arguments, found $#."
	echo
	display_help
	exit 1
fi

RUN_TIMEOUT=''
RUN_COMMAND=''
RUN_DIRECTORY=''

while getopts "hd:t:c:" option
do
	case $option in
		c)
			RUN_COMMAND=$OPTARG
			;;
		d)
			RUN_DIRECTORY=$OPTARG
			;;
		h)
			display_help
			exit;;
		t)
			RUN_TIMEOUT=$OPTARG
			;;
		\?)
			display_error "Error: invalid option"
			echo
			display_help
			exit;;
	esac
done

regex='^[0-9]+$'
if ! [[ $RUN_TIMEOUT =~ $regex ]]
then
	display_error "Error: The value for timeout option should be an integer. Found $RUN_TIMEOUT."
	echo
	display_help
	exit 1
fi

(
	if ! [[ -z $RUN_DIRECTORY ]]
	then
		cd $RUN_DIRECTORY
		echo "current directory is $(pwd)"
	fi

	eval $RUN_COMMAND
) 2> /dev/null &

sleep $RUN_TIMEOUT

pkill -P $! || true

sleep 1
