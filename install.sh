#!/bin/bash
export MAIN_DIR=$PWD
#mkdir bin

#requirefile() {
#	if [ ! -f "$1" ]; then
#		needdownload="1"
#    fi
#}

#requirefile "javabin"

if [ ! -d "tempscript" ]; then
    needdownload="1"
fi


if [ ! -z "$needdownload" ]; then
	echo -ne "Automatic download? [y/n]: "
	read automaticdownload
else
    automaticdownload="y"
fi

if [ "$automaticdownload" != "${automaticdownload#[Yy]}" ]; then
	echo -e "Everytime file required to download, we download automaticly"
	downloadauto="1"
	sleep 2
	clear
else
	echo -e "Everytime file required to download, we ask you first before downloaded"
	sleep 2
fi

require_dir() {
	if [ ! -d "$1" ]; then
		if [ ! -z "$downloadauto" ]; then
			echo "Making a dir named '$1'. Location: $MAIN_DIR"
			mkdir "$1"
		else
			echo "Please run this script with super root to make this dir named $1"
			echo -ne "Or create the directory now? [y/n]: "
			read makedir
		
			if [ "$makedir" != "${makedir#[Yy]}" ]; then
				echo -e "Making a dir named: '$1'"
				mkdir "$1"
			else
				echo -e ""
				echo -e "Cancelled the installasion."
				echo -e "Please make a dir named '$1' and start the installasion again"
				exit
			fi
		fi
	fi
}

require_dir "tempscript" "del"
cd tempscript

wgett() {
	if [ ! -z "$2" ]; then
		wget -O $2 $1 > /dev/null 2>&1
	else
		wget $1 > /dev/null 2>&1
	fi
}

require_file() {
	if [ ! -f "$1" ]; then
		if [ ! -z "$2" ]; then
			if [ ! -z "$downloadauto" ]; then
				echo -e "Downloaded required file named '$1'"
				wgett "$2" "$3"
			else
                echo ""
				echo -ne "The file required named '$1' doesn't exists, do you want to download? [y/n]: "
				read askfiledownload
       	        
				if [ "$askfiledownload" != "${askfiledownload#[Yy]}" ]; then
					echo ""
					echo "Downloading file '$1', this is required file, so don't be cancel this installasion..."
					wgett "$2" "$3"
					echo "Downloaded file '$1', continue installasion.."
					sleep 2
					clear
				else
					echo ""
					echo "Cancelled this installasion due required file doesn't be installed."
					exit
				fi
            fi
		else
			echo "The file are required named '$1' doesn't exists, cancelled the installasion"
			exit
		fi
  fi
}

executable() {
	require_file "$1" "$2" "$3"
	chmod +x "$1"
}

echo "Which Server do you want to install?"
echo "Type [1] Java Server"
echo "Type [2] Bedrock Server"

choiceForServer=1
read choiceForServer

# Installing Java 16 JDK and playit
#wget -q "https://download.java.net/java/GA/jdk16.0.1/7147401fd7354114ac51ef3e1328291f/9/GPL/openjdk-16.0.1_linux-x64_bin.tar.gz" -O bin/java.tar.xz
#wget -q "https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz" -O bin/java.tar.xz
cd $MAIN_DIR/bin
#echo "> Extracting Java JDK 16 to the bin/ folder. [THIS MAY TAKE SOME TIME] Replace it if you want to use older version of JAVA."
#tar -xf java.tar.xz && mv "jdk-17.0.1" java_bins

cd $MAIN_DIR
# If choice is 0 or null then run this command
if [[ -z $choiceForServer ]]; then

  echo "> Invaild Respond. Please try again."
  ./install

# If choice is 1 then run this command
elif [[ $choiceForServer == 1 ]]; then
	
	echo "> Running Java Installation..."
	cd tempscript
	executable "installjava" "https://github.com/marselk12/mcsrv/raw/main/javabin" "installjava"
  ./installJava

# If choice is 1 then run this command
elif [[ $choiceForServer == 2 ]]; then
	
	echo "> Running Bedrock Installation..."
  ./installBedrock

else
	echo "> Invaild Respond. Please try again."
	./install
fi
echo "> Installing AFK(Away From Keyboard) Script "
python3 -m pip install bpytop
echo ""

