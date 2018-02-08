# home-automation

My setup for home automation

Added code to minimize setup time, some things are nedded to be done before starting openhab.

1. Install docker CE and add user to docker group
2. Add user running the docker to dial group if needed (usb zwave stick for example)
3. Add rule.d file for zwave stick to get a specific /dev/<ttyUSBname> and use symlink in openhab.sh script:<br>
cat /etc/udev/rules.d/99-usb-serial.rules<br>
<code>SUBSYSTEM=="tty", ATTRS{idVendor}=="0658", ATTRS{idProduct}=="0200", SYMLINK+="ttyUSB-ZStick-5G"</code>
4. If running mysql, point the volume used to store data to a __completely__ empty dir.


That's all for now
