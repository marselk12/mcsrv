#!/bin/bash
mkdir bin
chmod +x *
export MAIN_DIR=$PWD
echo "Which Server do you want to install?"
echo "Type [1] Java Server"
echo "Type [2] Bedrock Server"

choiceForServer=1
read choiceForServer

# Installing Java 16 JDK and playit

#wget -q "https://download.java.net/java/GA/jdk16.0.1/7147401fd7354114ac51ef3e1328291f/9/GPL/openjdk-16.0.1_linux-x64_bin.tar.gz" -O bin/java.tar.xz
wget -q "https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz" -O bin/java.tar.xz
cd $MAIN_DIR/bin
echo "> Extracting Java JDK 16 to the bin/ folder. [THIS MAY TAKE SOME TIME] Replace it if you want to use older version of JAVA."
tar -xf java.tar.xz && mv "jdk-17.0.1" java_bins

cd $MAIN_DIR
# If choice is 0 or null then run this command
if [[ -z $choiceForServer ]]; then

  echo "> Invaild Respond. Please try again."
  ./install

# If choice is 1 then run this command
elif [[ $choiceForServer == 1 ]]; then
	
	echo "> Running Java Installation..."
	mkdir tempscript
	cd tempscript
wget -O installJava https://raw.githubusercontent.com/marselk12/mcsrv/main/javainstaller
chmod +x installJava
  ./installJava
  rm -rf installJava
  rm -rf InstallJava*

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

