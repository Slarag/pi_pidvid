#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Script must be run with root privileges"
  exit
fi


echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt
echo "dwc2" | sudo tee -a /etc/modules
echo "libcomposite" | sudo tee -a /etc/modules

echo "Please reboot your system"
