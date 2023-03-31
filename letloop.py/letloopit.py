#!/usr/bin/env python3
import os
import sys
import requests
from loguru import logger as log


LETLOOP = os.environ.get('LETLOOP', 'https://letloop.cloud/').rstrip('/')


def main():
    log.remove()
    if os.environ.get('LETLOOP_DEBUG'):
        log.add(sys.stderr)
        log.info('That is beautiful, and simple logging')

    match sys.argv[1:]:
        case [filename]:
            if not os.path.exists(filename):
                print('Oops! Look out for a typo, there is no file called: {}'.format(filename))
                exit(1)
            with open(filename, 'rb') as f:
                data = f.read()
            if not os.environ.get('LETLOOP_SUB'):
                url = "{}/api/v1".format(LETLOOP)
                try:
                    response = requests.post(url, data=data)
                except Exception as exc:
                    print('Oops! Pebkac somewhere over the rainbow...')
                    exit(1)
                if response.status_code != 201:
                    print('Oops! Pebkac somewhere over the rainbow...')
                    log.error((response.url, response.status_code))
                    exit(2)
            else:
                url = os.environ['LETLOOP_SECRET']
                try:
                    response = requests.put(url, data=data)
                except Exception as exc:
                    print('Oops! Pebkac somewhere over the rainbow...')
                    exit(3)
                if response.status_code != 200:
                    print('Oops! Pebkac somewhere over the rainbow...')
                    exit(4)
            try:
                response = response.json()
            except Exception:
                print('Oops! Pebkac somewhere over the rainbow...')
                exit(5)

            if response[0]:
                print(response[0])

            if not os.environ.get("LETLOOP_SUB"):
                _, SUB, SECRET = response
                print("")
                print("➰ It is online at: {}".format(SUB))

                if not os.environ.get('LETLOOP_SUB'):
                    os.environ["LETLOOP_SUB"] = SUB
                    os.environ["LETLOOP_SECRET"] = SECRET
                    print("")
                    print("➿ Spawning a new shell... Improve the code, push, and make it shine with the same command:")
                    print("")
                    print("     letloop.py {}".format(filename))
                    print("")
                    os.system(os.environ.get('SHELL', 'sh'))
        case _:
            print("")
            print("A cloud for the parenthetical leaning doers")
            print("")
            print("Usage:")
            print("")
            print(" 🌐️ letloop.py FILENAME")
            print("")
            print(" 📜 Caveat emptor: this service is alpha, use it at your own risks")
            print("")
            print(" 👋 For inspiration have a look at: https://github.com/letloop/letloop.cloud/")
            print("")


if __name__ == "__main__":
    main()
