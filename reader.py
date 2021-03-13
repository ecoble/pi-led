import RPi.GPIO as GPIO
from time import sleep
import time

GPIO.setmode(GPIO.BCM)

start_timestamp = 0
end_timestamp = 0
first_run = True
packets = []
pending_packet = []
last_was_start = False
dbg_print = False
enable_hex = True

# https://stackoverflow.com/a/312464/4948732
def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

def normalize_packet_int(i):
    if i > 0.4 and i < 0.7:
        return 0
    elif i > 1.3 and i < 2:
        return 1
    else:
        return i

def normalize_packet_int_str(i):
    if i == 0 or i == 1:
        return str(i)
    else:
        return "|" + str(i) + "|"

def cleanup_packet_ary(p):
    global enable_hex
    l = list(map(normalize_packet_int, p))
    should_run = len(l) == 66 and all(i == 0 or i == 1 for i in l[0:65])
    l = list(map(normalize_packet_int_str, l))
    if enable_hex == True and should_run:
        return "0x" + "".join(map(lambda c: "%X" % int("".join(c), 2) if len(c) == 4 else "".join(c), chunks(l, 4)))
    return "".join(l)

def my_callback(a):
    global last_was_start
    global start_timestamp
    global end_timestamp
    global first_run
    global pending_packet
    global packets
    if GPIO.input(17) == 0:
        start_timestamp = time.time() * 1000
        off_interval = start_timestamp - end_timestamp
        if off_interval > 20:
            if dbg_print: print("Looong off: " + str(off_interval))
        if first_run == False:
            if last_was_start and off_interval > 4 and off_interval < 5:
                if dbg_print: print("Packet start part 2 (" + str(off_interval) + ")")
            else:
                pending_packet.append(off_interval)
                if dbg_print: print("Off Interval: " + str(off_interval) + "ms")
        else:
            first_run = False
            if dbg_print: print("First rising Edge!")
    else:
        end_timestamp = time.time() * 1000
        on_interval = end_timestamp - start_timestamp
        if on_interval > 20:
            print("Looong on: " + str(on_interval))
        if (on_interval > 7 and on_interval < 11):
            if dbg_print: print("Packet start (" + str(on_interval) + ")")
            last_was_start = True
            if len(pending_packet) != 0:
                print("Pushing packet old: " + str(len(pending_packet)) + " / " + str(cleanup_packet_ary(pending_packet)))
                packets.append(pending_packet)
                pending_packet = []
        else:
            pending_packet.append(on_interval)
            if dbg_print: print("On Interval: " + str(on_interval) + "ms")


GPIO.setup(17, GPIO.IN)
GPIO.add_event_detect(17, GPIO.BOTH, callback=my_callback)


try:
    while (True):
        sleep(1)
        sleep(0.01)
        if False and end_timestamp != 0 and len(pending_packet) != 0 and (time.time() * 1000) - end_timestamp > 35:
            end_timestamp = 0
            start_timestamp = 0
            first_run = True
            print("Pushing packet: " + str(len(pending_packet)) + " / " + str(cleanup_packet_ary(pending_packet)))
            packets.append(pending_packet)
            pending_packet = []
finally:
#    if len(pending_packet) != 0:
#        packets.append(pending_packet)
#    for p in packets:
#        print("Packet: " + str(len(p)))
    GPIO.cleanup()
