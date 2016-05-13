from sbp.client.drivers.pyserial_driver import PySerialDriver
from sbp.client import Handler, Framer
from sbp.user import *
import argparse

def main():
    parser = argparse.ArgumentParser(description="Swift Navigation SBP Example.")
    parser.add_argument("-p", "--port",
                        default=['/dev/ttyUSB0'], nargs=1,
                        help="specify the serial port to use.")
    args = parser.parse_args()

    # Open a connection to Piksi using the default baud rate (1Mbaud)
    with PySerialDriver(args.port[0], baud=2400) as driver:
        with Handler(Framer(driver.read, driver.write, verbose=True)) as source:
            msg = MsgUserPwm(pwm0=1, pwm1=2, pwm2=3, pwm3=4)
            source(msg)

if __name__ == "__main__":
    main()

