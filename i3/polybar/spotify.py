#!/usr/bin/python3
# Stolen from https://github.com/firatakandere/i3blocks-spotify though modified heavily
# This will ouptput the currently playing song on Spotify, cycling if the title is more than 30 characters
import dbus
import os
import time

MAX_SIZE = 30 # The max length of the title to display at any given time
POS_FILE = '/home/funnyboy_roks/.config/i3/polybar/position.txt' # The text file that stores a single number for saving the current position of the cycling song

try:
    v = 0
    if os.path.isfile(POS_FILE):
        with open(POS_FILE, 'r') as f:
            try:
                v = int(f.read())
            except ValueError:
                pass
    bus = dbus.SessionBus()
    spotify = bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")

    if os.environ.get('BLOCK_BUTTON'):
        control_iface = dbus.Interface(
            spotify, 'org.mpris.MediaPlayer2.Player')
        if (os.environ['BLOCK_BUTTON'] == '1'):
            control_iface.Previous()
        elif (os.environ['BLOCK_BUTTON'] == '2'):
            control_iface.PlayPause()
        elif (os.environ['BLOCK_BUTTON'] == '3'):
            control_iface.Next()

    spotify_iface = dbus.Interface(spotify, 'org.freedesktop.DBus.Properties')
    props = spotify_iface.Get('org.mpris.MediaPlayer2.Player', 'Metadata')

    artist = str(props['xesam:artist'][0])
    title = str(props['xesam:title'])

    if len(title) < MAX_SIZE:
        v = 0
    else:
        title = (title + '    ' + title)[v:MAX_SIZE + v]
    
    if v > len(title):
        v = 0


    print(f"{artist} - {title}")

    v += 1
    
    with open(POS_FILE, 'w') as f:
        f.write(str(v))

except dbus.exceptions.DBusException:
        pass   
