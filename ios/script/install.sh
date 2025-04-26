#!/bin/bash
set -e
trap "sleep 1; echo" EXIT

target_directory=""
zip_file_path=""


function display_help()
{
	echo
	./script/echocolor.sh -y "The " -Y "$0 script" -y " installs plugin in the specified directory"
	echo
	./script/echocolor.sh -Y "Syntax:"
	./script/echocolor.sh -y "	$0 [-h|t <target directory path>|z <zip file path>]"
	echo
	./script/echocolor.sh -Y "Options:"
	./script/echocolor.sh -y "	h	display usage information"
	./script/echocolor.sh -y "	t	specify the path for target directory"
	./script/echocolor.sh -y "	z	specify the path for zip file"
	echo
	./script/echocolor.sh -Y "Examples:"
	./script/echocolor.sh -y "	* install plugin in project"
	./script/echocolor.sh -y "	   $> $0 -t /mypath/myproject -z ../myzipfile.zip"
	echo
}


function display_status()
{
	echo
	./script/echocolor.sh -c "********************************************************************************"
	./script/echocolor.sh -c "* $1"
	./script/echocolor.sh -c "********************************************************************************"
	echo
}


function display_warning()
{
	./script/echocolor.sh -y "$1"
}


function display_error()
{
	./script/echocolor.sh -r "$1"
}


while getopts "aA:bcgG:hHipPt:z:" option; do
	case $option in
		h)
			display_help
			exit;;
		t)
			if ! [[ -z $OPTARG ]]
			then
				target_directory=$OPTARG
			fi
			;;
		z)
			if ! [[ -z $OPTARG ]]
			then
				zip_file_path=$OPTARG
			fi
			;;
		\?)
			display_error "Error: invalid option"
			echo
			display_help
			exit;;
	esac
done

if [[ ! -f "$zip_file_path" ]]
then
	display_error "Error: zip file '$zip_file_path' not found"
	exit 1
fi

if [[ ! -d "$target_directory" ]]
then
	display_status "creating target directory $target_directory"
	mkdir -p $target_directory
fi

display_status "installing $zip_file_path in $target_directory"

unzip -o $zip_file_path -d $target_directory
