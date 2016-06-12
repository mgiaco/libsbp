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
    with PySerialDriver(args.port[0], baud=2400) as driver:
        with Handler(Framer(driver.read, driver.write, verbose=True)) as source:

            driver.write('pedapeda')

            source(MsgUserPwm(pwm0=0, pwm1=0, pwm2=0, pwm3=0))
            time.sleep(2)

            source(MsgUserPwm(pwm0=50, pwm1=50, pwm2=0, pwm3=0))
            time.sleep(2)

            #
            # source(MsgUserCmd(cmd=10, data=128))
            # time.sleep(2)
            #
            # source(MsgUserCmd(cmd=254, data=128))
            # time.sleep(2)
            #
            # source(MsgUserCmd(cmd=255, data=128))
            # time.sleep(2)
            #
            # source(MsgUserData(contents=bytearray('Hallo 1234')))
            # time.sleep(2)
            #
            # source(MsgUserCmd(cmd=10, data=1, sender=255))
            # time.sleep(2)
            #
            # source(MsgUserPwm(pwm0=0, pwm1=0, pwm2=0, pwm3=0, sender=1))
            # time.sleep(2)
            #
            # source(MsgUserPwm(pwm0=10, pwm1=0, pwm2=20, pwm3=0, sender=1))
            # time.sleep(2)
            #
            # source(MsgUserPwm(pwm0=0, pwm1=50, pwm2=0, pwm3=0, sender=2))
            # time.sleep(2)
            #
            # source(MsgUserCmd(cmd=20, data=1, sender=1))
            # time.sleep(2)
            #
            # source(MsgUserPwm(pwm0=0, pwm1=50, pwm2=0, pwm3=0, sender=2))
            # time.sleep(2)
            #
            # source(MsgUserCmd(cmd=10, data=5, sender=1))
            # time.sleep(2)
            #
            # source(MsgUserCmd(cmd=20, data=0, sender=5))
            # time.sleep(2)

            # try:
            #     while True:
            #         source(MsgUserPwm(pwm0=70, pwm1=0, pwm2=0, pwm3=0))
            #         print "red"
            #         time.sleep(1)
            #
            #         msg = MsgUserPwm(pwm0=0, pwm1=70, pwm2=0, pwm3=0)
            #         source(msg)
            #         print "green"
            #         time.sleep(1)
            #
            #         msg = MsgUserPwm(pwm0=0, pwm1=0, pwm2=50, pwm3=0)
            #         source(msg)
            #         print "blue"
            #         time.sleep(1)
            #
            #         msg = MsgUserPwm(pwm0=0, pwm1=0, pwm2=0, pwm3=50)
            #         source(msg)
            #         print "white"
            #         time.sleep(1)
            #
            #         msg = MsgUserPwm(pwm0=255, pwm1=41, pwm2=144, pwm3=0)
            #         source(msg)
            #         print("violett")
            #         time.sleep(1)
            #
            # except KeyboardInterrupt:
            #     pass

if __name__ == "__main__":
    main()

