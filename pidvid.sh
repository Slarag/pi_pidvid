#!/bin/bash

DEVNAME="pi_pidvid"

if [ "$EUID" -ne 0 ]
  then echo "Script must be run with root privileges"
  exit
fi

mkdir -p 
pushd /sys/kernel/config/usb_gadget/$DEVNAME > /dev/null

while true
do
  echo "Select Pattern Type:
    1) TEST_SE0_NAK
    2) TEST_J
    3) TEST_K
    4) TEST_PACKET
    5) RESERVED
    6) HS_HOST_PORT_SUSPEND_RESUME
    7) SINGLE_STEP_GET_DEV_DESC
    8) SINGLE_STEP_SET_FEATURE
    9) TTST_CONFIG
    10) Unknown Device Not Supporting HNP
    11) Unknown Device Supporting HNP
    12) Exit"
  read -p "Select: "

  case $REPLY in
    1)
      PID=0x0101
      ;;
    2)
      PID=0x0102
      ;;
    3)
      PID=0x0103
      ;;
    4)
      PID=0x0104
      ;;
    5)
      PID=0x0105
      ;;
    6)
      PID=0x0106
      ;;
    7)
      PID=0x0107
      ;;
    8)
      PID=0x0108
      ;;
    9)
      PID=0x0200
      ;;
    10)
      PID=0x0201
      ;;
    11)
      PID=0x0202
      ;;
    12)
      break
      ;;
    *)
      echo "Invalid Selection!"
    continue
      ;;
  esac

  # Create USB gadget with according PID/VID
  echo 0x1A0A > idVendor # VID
  echo $PID > idProduct # PID
  echo 0x0100 > bcdDevice # v1.0.0
  echo 0x0200 > bcdUSB # USB2
  mkdir -p strings/0x409
  echo "fedcba9876543210" > strings/0x409/serialnumber
  #echo "" > strings/0x409/manufacturer
  echo "USB2 Compliance Pattern PIDVID" > strings/0x409/product
  mkdir -p configs/c.1/strings/0x409
  echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
  echo 250 > configs/c.1/MaxPower
  ls /sys/class/udc > UDC

  read -p "Press enter to reset usb devie"
  # Detach and delete USB gadget
  echo "" > UDC
  rmdir configs/c.1/strings/0x409
  rmdir configs/c.1
  rmdir strings/0x409
done

popd > /dev/null
