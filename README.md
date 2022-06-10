Pi-PIDVID
=========

This script utilizes a Raspberry Pi to emulate a USB device with VID/PID used during USB High Speed compliance testing of an embedded host.
This way, you can use a Raspberry Pi as much cheaper replacement for the PIDVID board.

PID/VID spec is based on [PIDVID USB 2.0 High Speed Electrical Embedded Host and OTG MOI](https://usb.org/document-library/pidvid-usb-20-high-speed-electrical-embedded-host-and-otg-moi) - Section 3.2.

USB device setup is based on [this article](https://www.isticktoit.net/?p=1383).

Installation
------------

1. Run ```./setup.sh``` whit root privileges on the Raspberry Pi to enable/load the required modules/drives at boot time.
2. Reboot your Raspberry Pi.

Usage
-----

1. Boot your Raspberry Pi
2. Connect the client USB port of the Raspberry Pi to your DUT (Device under Test).
	* On the Raspberry Pi 4 this is the USB C-type connector used to supply power.
		+ Either build yourself a splitter cable which separates power and data lines
		+ Or supply power to the Pi through the GPIO pin header
	* Rasberry Pi Model B (except Pi 4) do not support this feature
	* On the Raspberry Pi Zero, you can directly use the Micro USB connector
	* For a model A, you would need an A-to-A cable with VBUS not connected
3. During complaince testing, the Raspbery Pi client port acts as the "Known good Hi-Speed Device".
4. When prompted to set a specific pattern, run ```./pidvid.sh``` with root privileges, select the according pattern and continue with the measurements.

Limitations/Bugs
----------------

* This is currently only a draft and has not been tested.