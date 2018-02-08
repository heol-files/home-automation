# home-automation

My setup fo home automation

Added code o minimize setup time, some things are nedded to be done before starting openhab.

1. Install docker CE and add user to docker group
2. Add user running the docker to dial group if needed (usb zwave stick for example)
3. Add rule for zwave stick to get a specifig /dev/<ttyUSBname> and add it in openhab.sh script Like:
cat /etc/udev/rules.d/99-usb-serial.rules 
SUBSYSTEM=="tty", ATTRS{idVendor}=="0658", ATTRS{idProduct}=="0200", SYMLINK+="ttyUSB-ZStick-5G" 

That's all for now
