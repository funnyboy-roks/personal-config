#!/bin/bash
# Usage: ./multi-monitor-img-gen.sh <source> <target>
# Create an image for a multimonitor setup from a single image (intended for i3lock)
# Requires ImageMagick

DISPLAY_RE="([0-9]+)x([0-9]+)\\+([0-9]+)\\+([0-9]+)" # Regex to find display dimensions
CACHE_FOLDER="$(dirname $(dirname $0))/multimonitor-CACHE/" # Cache folder

if ! [ -e $CACHE_FOLDER ]; then
    mkdir -p $CACHE_FOLDER
fi;

OUTPUT_IMG_WIDTH=0 # Decide size to cover all screens
OUTPUT_IMG_HEIGHT=0 # Decide size to cover all screens

# Execute xrandr to get information about the monitors:
while read LINE
do
    #If we are reading the line that contains the position information:
    if [[ $LINE =~ $DISPLAY_RE ]]; then
    #Extract information and append some parameters to the ones that will be given to ImageMagick:
    SCREEN_WIDTH=${BASH_REMATCH[1]}
    SCREEN_HEIGHT=${BASH_REMATCH[2]}
    SCREEN_X=${BASH_REMATCH[3]}
    SCREEN_Y=${BASH_REMATCH[4]}
    
    CACHE_IMG="${CACHE_FOLDER}${SCREEN_WIDTH}x${SCREEN_HEIGHT}.png"
    eval convert '$1' '-resize' '${SCREEN_WIDTH}X${SCREEN_HEIGHT}^' '-gravity' 'Center' '-crop' '${SCREEN_WIDTH}X${SCREEN_HEIGHT}+0+0' '+repage' '$CACHE_IMG'

    # Decide size of output image
    if (( $OUTPUT_IMG_WIDTH < $SCREEN_WIDTH+$SCREEN_X )); then OUTPUT_IMG_WIDTH=$(($SCREEN_WIDTH+$SCREEN_X)); fi;
    if (( $OUTPUT_IMG_HEIGHT < $SCREEN_HEIGHT+$SCREEN_Y )); then OUTPUT_IMG_HEIGHT=$(( $SCREEN_HEIGHT+$SCREEN_Y )); fi;

    PARAMS="$PARAMS -type TrueColor $CACHE_IMG -geometry +$SCREEN_X+$SCREEN_Y -composite "
    fi
done <<<"`xrandr`"


#Execute ImageMagick:
eval convert -size "${OUTPUT_IMG_WIDTH}x${OUTPUT_IMG_HEIGHT}" 'xc:black' "$2"
eval convert "$2" "$PARAMS" "$2"

rm -r "$CACHE_FOLDER"