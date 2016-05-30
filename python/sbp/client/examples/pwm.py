from sbp.client.drivers.pyserial_driver import PySerialDriver
from sbp.client import Handler, Framer

from sbp.user import *
import argparse
import time

def main():
    parser = argparse.ArgumentParser(description="Swift Navigation SBP Example.")
    parser.add_argument("-p", "--port",
                        default=['/dev/ttyUSB0'], nargs=1,
                        help="specify the serial port to use.")
    args = parser.parse_args()

    # Open a connection to Piksi using the default baud rate (1Mbaud)
    with PySerialDriver(args.port[0], baud=115200) as driver:
        with Handler(Framer(driver.read, driver.write, verbose=True)) as source:
            try:
                while True:
                    time.sleep(1)
                    msg = MsgUserPwm(pwm0=255, pwm1=70, pwm2=255, pwm3=255, sender=55)
                    source(msg)
                    print "send"
            except KeyboardInterrupt:
                pass

if __name__ == "__main__":
    main()

