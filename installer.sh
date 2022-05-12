#!/bin/bash

sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl --no-check-certificate
sudo chmod a+rx /usr/local/bin/youtube-dl
sudo ln -s /usr/bin/python3 /usr/local/bin/python
sudo apt-get install atomicparsley
sudo apt install ffmpeg