import time
import os

printedList = ["pittsburgh.jpg"]
path = "/Users/marisalu/Documents/NSR/MarisaNSR/NSR/data" # path to the python script

while True:

    for filename in os.listdir(path):
        if filename.endswith(".jpg"):
             if filename not in printedList:
                 time.sleep(5) # this is to prevent any read/write issues
                 os.system("lpr " + filename)
                 printedList.append(filename) # so it doesn't print the same one twice
