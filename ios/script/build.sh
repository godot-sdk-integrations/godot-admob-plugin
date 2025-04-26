#!/bin/bash
set -e
trap "sleep 1; echo" EXIT

PLUGIN_NODE_TYPE="Admob"
PLUGIN_NAME="${PLUGIN_NODE_TYPE}Plugin"
PLUGIN_VERSION=''
PLUGIN_DEPENDENCIES=""
TARGET_OS="ios"
SUPPORTED_GODOT_VERSIONS=("4.2" "4.3" "4.4.1" "4.5")
BUILD_TIMEOUT=40	# increase this value using -t option if device is not able to generate all headers before godot build is killed

DEST_DIRECTORY="./bin/release"
FRAMEWORKDIR="./bin/framework"
LIB_DIRECTORY="./bin/lib"
CONFIG_DIRECTORY="./config"

do_clean=false
do_remove_pod_trunk=false
do_remove_godot=false
do_download_godot=false
do_generate_headers=false
do_install_pods=false
do_build=false
do_create_zip=false
ignore_unsupported_godot_version=false


function display_help()
{
	echo
	./script/echocolor.sh -y "The " -Y "$0 script" -y " builds the plugin, generates library archives, and"
	./script/echocolor.sh -y "creates a zip file containing all libraries and configuration."
	echo
	./script/echocolor.sh -y "If plugin version is not set with the -z option, then Godot version will be used."
	echo
	./script/echocolor.sh -Y "Syntax:"
	./script/echocolor.sh -y "	$0 [-a|A <godot version>|c|g|G <godot version>|h|H|i|p|P|t <timeout>|z <version>]"
	echo
	./script/echocolor.sh -Y "Options:"
	./script/echocolor.sh -y "	a	generate godot headers and build plugin"
	./script/echocolor.sh -y "	A	download specified godot version, generate godot headers, and"
	./script/echocolor.sh -y "	 	build plugin"
	./script/echocolor.sh -y "	b	build plugin"
	./script/echocolor.sh -y "	c	remove any existing plugin build"
	./script/echocolor.sh -y "	g	remove godot directory"
	./script/echocolor.sh -y "	G	download the godot version specified in the option argument"
	./script/echocolor.sh -y "	 	into godot directory"
	./script/echocolor.sh -y "	h	display usage information"
	./script/echocolor.sh -y "	H	generate godot headers"
	./script/echocolor.sh -y "	i	ignore if an unsupported godot version selected and continue"
	./script/echocolor.sh -y "	p	remove pods and pod repo trunk"
	./script/echocolor.sh -y "	P	install pods"
	./script/echocolor.sh -y "	t	change timeout value for godot build"
	./script/echocolor.sh -y "	z	create zip archive with given version added to the file name"
	echo
	./script/echocolor.sh -Y "Examples:"
	./script/echocolor.sh -y "	* clean existing build, remove godot, and rebuild all"
	./script/echocolor.sh -y "	   $> $0 -cgA 4.2"
	./script/echocolor.sh -y "	   $> $0 -cgpG 4.2 -HPbz 1.0"
	echo
	./script/echocolor.sh -y "	* clean existing build, remove pods and pod repo trunk, and rebuild plugin"
	./script/echocolor.sh -y "	   $> $0 -cpPb"
	echo
	./script/echocolor.sh -y "	* clean existing build and rebuild plugin"
	./script/echocolor.sh -y "	   $> $0 -ca"
	./script/echocolor.sh -y "	   $> $0 -cHbz 1.0"
	echo
	./script/echocolor.sh -y "	* clean existing build and rebuild plugin with custom plugin version"
	./script/echocolor.sh -y "	   $> $0 -cHbz 1.0"
	echo
	./script/echocolor.sh -y "	* clean existing build and rebuild plugin with custom build timeout"
	./script/echocolor.sh -y "	   $> $0 -cHbt 15"
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


function remove_godot_directory()
{
	if [[ -d "godot" ]]
	then
		display_status "removing 'godot' directory..."
		rm -rf "godot"
	else
		display_warning "'godot' directory not found..."
	fi
}


function clean_plugin_build()
{
	display_status "cleaning existing build directories and generated files..."
	rm -rf ./bin/*
	find . -name "*.d" -type f -delete
	find . -name "*.o" -type f -delete
}


function remove_pods()
{
	if [[ -d ./Pods ]]
	then
		rm -rf ./Pods/
	else
		display_warning "Warning: './Pods' directory does not exist"
	fi
}


function download_godot()
{
	if [[ $# -eq 0 ]]
	then
		display_error "Error: Please provide the Godot version as an option argument for -G option."
		exit 1
	fi

	if [[ -d "godot" ]]
	then
		display_error "Error: godot directory already exists. Won't download."
		exit 1
	fi

	SELECTED_GODOT_VERSION=$1
	display_status "downloading godot version $SELECTED_GODOT_VERSION..."

	godot_directory="godot-${SELECTED_GODOT_VERSION}-stable"
	godot_archive_file_name="${godot_directory}.tar.xz"

	curl -LO "https://github.com/godotengine/godot/releases/download/${SELECTED_GODOT_VERSION}-stable/${godot_archive_file_name}"
	tar -xf "$godot_archive_file_name"

	mv "$godot_directory" godot
	rm $godot_archive_file_name

	echo "$SELECTED_GODOT_VERSION" > godot/GODOT_VERSION
}


function generate_godot_headers()
{
	if [[ ! -d "godot" ]]
	then
		display_error "Error: godot directory does not exist. Can't generate headers."
		exit 1
	fi

	display_status "starting godot build to generate godot headers..."

	./script/run_with_timeout.sh -t $BUILD_TIMEOUT -c "scons platform=ios target=template_release" -d ./godot || true

	display_status "terminated godot build after $BUILD_TIMEOUT seconds..."
}


function generate_static_library()
{
	if [[ ! -f "./godot/GODOT_VERSION" ]]
	then
		display_error "Error: godot wasn't downloaded properly. Can't generate static library."
		exit 1
	fi

	GODOT_VERSION=$(cat ./godot/GODOT_VERSION)

	TARGET_TYPE="$1"
	lib_directory="$2"

	display_status "generating static libraries for $PLUGIN_NAME with target type $TARGET_TYPE..."

	# ARM64 Device
	scons target=$TARGET_TYPE arch=arm64 target_name=$PLUGIN_NAME version=$GODOT_VERSION
	# x86_64 Simulator
	scons target=$TARGET_TYPE arch=x86_64 simulator=yes target_name=$PLUGIN_NAME version=$GODOT_VERSION

	# Creating fat library for device and simulator
	lipo -create "$lib_directory/lib$PLUGIN_NAME.x86_64-simulator.$TARGET_TYPE.a" \
		"$lib_directory/lib$PLUGIN_NAME.arm64-ios.$TARGET_TYPE.a" \
		-output "$lib_directory/$PLUGIN_NAME.$TARGET_TYPE.a"
}


function install_pods()
{
	display_status "installing pods..."
	pod install --repo-update || true
}


function build_plugin()
{
	if [[ ! -f "./godot/GODOT_VERSION" ]]
	then
		display_error "Error: godot wasn't downloaded properly. Can't build plugin."
		exit 1
	fi

	GODOT_VERSION=$(cat ./godot/GODOT_VERSION)

	# Clear target directories
	rm -rf "$DEST_DIRECTORY"
	rm -rf "$LIB_DIRECTORY"

	# Create target directories
	mkdir -p "$DEST_DIRECTORY"
	mkdir -p "$LIB_DIRECTORY"

	display_status "building plugin library with godot version $GODOT_VERSION ..."

	# Compile library
	generate_static_library release $LIB_DIRECTORY
	generate_static_library release_debug $LIB_DIRECTORY
	mv $LIB_DIRECTORY/$PLUGIN_NAME.release_debug.a $LIB_DIRECTORY/$PLUGIN_NAME.debug.a

	# Move library
	cp $LIB_DIRECTORY/$PLUGIN_NAME.{release,debug}.a "$DEST_DIRECTORY"

	cp "$CONFIG_DIRECTORY"/*.gdip "$DEST_DIRECTORY"
}


function create_zip_archive()
{
	if [[ ! -f "./godot/GODOT_VERSION" ]]
	then
		display_error "Error: godot wasn't downloaded properly. Can't create zip archive."
		exit 1
	fi

	GODOT_VERSION=$(cat ./godot/GODOT_VERSION)

	if [[ -z $PLUGIN_VERSION ]]
	then
		godot_version_suffix="v$GODOT_VERSION"
	else
		godot_version_suffix="v$PLUGIN_VERSION"
	fi

	file_name="$PLUGIN_NAME-$godot_version_suffix.zip"

	if [[ -e "./bin/release/$file_name" ]]
	then
		display_warning "deleting existing $file_name file..."
		rm ./bin/release/$file_name
	fi

	tmp_directory="./bin/.tmp_zip_"
	addon_directory="../addon"

	if [[ -d "$tmp_directory" ]]
	then
		display_status "removing existing staging directory $tmp_directory"
		rm -r $tmp_directory
	fi

	if [[ -d "$addon_directory" ]]
	then
		mkdir -p $tmp_directory/addons/$PLUGIN_NAME
		cp -r $addon_directory/* $tmp_directory/addons/$PLUGIN_NAME
		sed -i '' -e "s/@pluginName@/$PLUGIN_NAME/g" $tmp_directory/addons/$PLUGIN_NAME/*.{gd,cfg}
		sed -i '' -e "s/@pluginVersion@/$PLUGIN_VERSION/g" $tmp_directory/addons/$PLUGIN_NAME/*.{gd,cfg}
		sed -i '' -e "s/@pluginNodeName@/$PLUGIN_NODE_TYPE/g" $tmp_directory/addons/$PLUGIN_NAME/*.{gd,cfg}
		sed -i '' -e "s/@pluginDependencies@/$PLUGIN_DEPENDENCIES/g" $tmp_directory/addons/$PLUGIN_NAME/*.{gd,cfg}
		sed -i '' -e "s/@targetOs@/$TARGET_OS/g" $tmp_directory/addons/$PLUGIN_NAME/*.{gd,cfg}
	fi

	mkdir -p $tmp_directory/ios/framework
	find ./Pods -iname '*.xcframework' -type d -exec cp -r {} $tmp_directory/ios/framework \;

	mkdir -p $tmp_directory/ios/plugins
	cp $CONFIG_DIRECTORY/*.gdip $tmp_directory/ios/plugins
	cp $LIB_DIRECTORY/$PLUGIN_NAME.{release,debug}.a $tmp_directory/ios/plugins

	mkdir -p $DEST_DIRECTORY

	display_status "creating $file_name file..."
	cd $tmp_directory; zip -yr ../release/$file_name ./*; cd -

	rm -rf $tmp_directory
}


while getopts "aA:bcgG:hHipPt:z:" option; do
	case $option in
		h)
			display_help
			exit;;
		a)
			do_generate_headers=true
			do_install_pods=true
			do_build=true
			;;
		A)
			GODOT_VERSION=$OPTARG
			do_download_godot=true
			do_generate_headers=true
			do_install_pods=true
			do_build=true
			;;
		b)
			do_build=true
			;;
		c)
			do_clean=true
			;;
		g)
			do_remove_godot=true
			;;
		G)
			GODOT_VERSION=$OPTARG
			do_download_godot=true
			;;
		H)
			do_generate_headers=true
			;;
		i)
			ignore_unsupported_godot_version=true
			;;
		p)
			do_remove_pod_trunk=true
			;;
		P)
			do_install_pods=true
			;;
		t)
			regex='^[0-9]+$'
			if ! [[ $OPTARG =~ $regex ]]
			then
				display_error "Error: The argument for the -t option should be an integer. Found $OPTARG."
				echo
				display_help
				exit 1
			else
				BUILD_TIMEOUT=$OPTARG
			fi
			;;
		z)
			if ! [[ -z $OPTARG ]]
			then
				PLUGIN_VERSION=$OPTARG
			fi
			do_create_zip=true
			;;
		\?)
			display_error "Error: invalid option"
			echo
			display_help
			exit;;
	esac
done

if ! [[ " ${SUPPORTED_GODOT_VERSIONS[*]} " =~ [[:space:]]${GODOT_VERSION}[[:space:]] ]]
then
	if [[ "$do_download_godot" == false ]]
	then
		display_warning "Warning: Godot version not specified. Will look for existing download."
	elif [[ "$ignore_unsupported_godot_version" == true ]]
	then
		display_warning "Warning: Godot version '$GODOT_VERSION' is not supported. Supported versions are [${SUPPORTED_GODOT_VERSIONS[*]}]."
	else
		display_error "Error: Godot version '$GODOT_VERSION' is not supported. Supported versions are [${SUPPORTED_GODOT_VERSIONS[*]}]."
		exit 1
	fi
fi

if [[ "$do_clean" == true ]]
then
	clean_plugin_build
fi

if [[ "$do_remove_pod_trunk" == true ]]
then
	remove_pods
fi

if [[ "$do_remove_godot" == true ]]
then
	remove_godot_directory
fi

if [[ "$do_download_godot" == true ]]
then
	download_godot $GODOT_VERSION
fi

if [[ "$do_generate_headers" == true ]]
then
	generate_godot_headers
fi

if [[ "$do_install_pods" == true ]]
then
	install_pods
fi

if [[ "$do_build" == true ]]
then
	build_plugin
fi

if [[ "$do_create_zip" == true ]]
then
	create_zip_archive
fi
