#!/usr/bin/env python3

import logging
import os
import time
from dotenv import load_dotenv
from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler

# Load environment variables from .env file
load_dotenv('mylogservice.env')

# Load config variables from env file
verbose = int(os.environ.get('VERBOSE', 0))
directory = os.environ.get('DIRECTORY', '/tmp/')
print("Verbose: " + str(verbose))
print("Directory: " + directory)

if __name__ == "__main__":
    if verbose:
        # define where to log
        log_file = '/home/balbir/pjct/pyprgs/mylogservice/mylogservice.log'
        logging.basicConfig(filename=log_file, level=logging.INFO,
                            format='%(asctime)s - %(message)s',
                            datefmt='%Y-%m-%d %H:%M:%S')

    event_handler = LoggingEventHandler()
    observer = Observer()
    observer.schedule(event_handler, directory, recursive=True)
    observer.start()

    try:
        while True:
            time.sleep(1)
    finally:
        observer.stop()
        observer.join()
