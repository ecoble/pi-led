# pi-led
This project allows you to use a Raspberry Pi as a remote to control strip LED lights.
This is a proof of concept and could be generalized to work with any remote that uses infrared sensors.
Setup for the project based on this tutorial https://www.digikey.com/en/maker/blogs/2021/how-to-send-and-receive-ir-signals-with-a-raspberry-pi

## Set up

Edit the config file to allow for sending and receiving IR signals 
```
sudo vim /boot/config.txt
```
Uncomment the following lines, or add them if they do not exist (note that pin numbers should be configured to your own setup)
```
dtoverlay=gpio-ir,gpio_pin=23 # for receiving data
dtoverlay=gpio-ir-tx,gpio_pin=22 # for sending commands
```
Reboot the pi
```
reboot
```

Install LIRC (Linux Infrared Remote Control)
```
sudo apt install lirc
```

Once this is done, change the configuration file
```
sudo vim /etc/lirc/lirc_options.conf
```
Change the following lines
```
driver = default
device = /dev/lirc0
```

Copy the contents of the ledconfig file into /etc/lirc/lircd.conf
Reboot the pi again.

You should now be able to send signals to LED lights using the mappings from the config file

## Usage

Signals can be sent from the command line
```
irsend SEND_ONCE ledall KEY_1
```
Or the python file send.py has functions that map these keys to their button function on a standard remote


