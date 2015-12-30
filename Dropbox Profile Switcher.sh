#!/bin/sh
# This is a Dropbox profile switcher
# --- Author by Jeremy Lee ---
# Version 1.0
# Created date : 2015, 12, 28
# Revision 2
#
#
DIRECTORY_DROPBOX_ACTIVATED=~/.dropbox
DIRECTORY_DROPBOX1_ACTIVATED=~/.dropbox1
DIRECTORY_DROPBOX2_ACTIVATED=~/.dropbox2
ACTIVATED_ACCOUNT=0
AUTO_LAUNCH=1

if [ -d "$DIRECTORY_DROPBOX2_ACTIVATED" -a -d "$DIRECTORY_DROPBOX_ACTIVATED" ]
then
  if ! [ -d "$DIRECTORY_DROPBOX1_ACTIVATED" ]; then
	# Control will enter here if $DIRECTORY exists.
	ACTIVATED_ACCOUNT=1
  fi
elif [ -d "$DIRECTORY_DROPBOX1_ACTIVATED" -a -d "$DIRECTORY_DROPBOX_ACTIVATED" ]; then
  if ! [ -d "$DIRECTORY_DROPBOX2_ACTIVATED" ]; then
	# Control will enter here if $DIRECTORY exists.
	ACTIVATED_ACCOUNT=2
  fi
else
  # Control will enter here if $DIRECTORY exists.
  ACTIVATED_ACCOUNT=0
fi

echo '''
######## Dropbox Profile Switcher ########
######## ------ Jeremy Lee ------ ########

Detecting currect activated account id ... Done
Dropbox Profile is currently registered as account '$ACTIVATED_ACCOUNT'
'''
echo 

read -s -n 1 -p "Press any key to continue... "

# Check if Dropbox is running
if pgrep "Dropbox" > /dev/null
then
	echo "Dropbox is Running, please close it and try again"
else
	if [ "$ACTIVATED_ACCOUNT" == "1" ]
	then
		mv $DIRECTORY_DROPBOX_ACTIVATED $DIRECTORY_DROPBOX1_ACTIVATED
		mv $DIRECTORY_DROPBOX2_ACTIVATED $DIRECTORY_DROPBOX_ACTIVATED
		echo "Now account 2 has been activated successfully !"
		echo "Enjoy !"
		if [ "$AUTO_LAUNCH" == "1" ]
		then
			nohup /Applications/Dropbox.app/Contents/MacOS/Dropbox >> /dev/null &
		fi
	elif [ "$ACTIVATED_ACCOUNT" == "2" ]
	then
		mv $DIRECTORY_DROPBOX_ACTIVATED $DIRECTORY_DROPBOX2_ACTIVATED
		mv $DIRECTORY_DROPBOX1_ACTIVATED $DIRECTORY_DROPBOX_ACTIVATED
		echo "Now account 1 has been activated successfully !"
		echo "Enjoy !"
		if [ "$AUTO_LAUNCH" == "1" ]
		then
			nohup /Applications/Dropbox.app/Contents/MacOS/Dropbox >> /dev/null &
		fi
	elif [ "$ACTIVATED_ACCOUNT" == "0" ]
	then
		echo "Something got wrong : ( Maybe you have not registered two accounts on this computer yet !"
	fi
fi
