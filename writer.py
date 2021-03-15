import RPi.GPIO as GPIO
from time import sleep
import time
import sys

GPIO.setmode(GPIO.BCM)
GPIO.setup(2, GPIO.OUT)

def convert_to_instrs(str):
    if str[0:2] == "0x":
        return bin(int(str[3:], 16))[2:68]
    else:
        return str


print(convert_to_instrs(sys.argv[1]))
print(len(convert_to_instrs(sys.argv[1])))

GPIO.output(2, GPIO.HIGH)
sleep(0.009)
GPIO.output(2, GPIO.LOW)
sleep(0.004)
gpio = GPIO.HIGH
for state in convert_to_instrs(sys.argv[1]):
    GPIO.output(2, gpio)
    if (state == "0"):
        sleep(0.0005)
    elif (state == "1"):
        sleep(0.0015)
    else:
        print("wtf1")
    if gpio == GPIO.HIGH:
        gpio = GPIO.LOW
    elif gpio == GPIO.LOW:
        gpio = GPIO.HIGH
    else:
        print("Wtf 2")

GPIO.cleanup()
