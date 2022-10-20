#!/bin/sh

# This script requires ffmpeg to run. ffmpeg can be downloaded via brew.
# > $brew install ffmpeg

output_flag=''
quality_flag='l'

print_usage() {
    printf "Usage:\n-o for output file name\n-q for quality (f for full, h for high, or l for low)"
}

while getopts 'o:q:' flag; do
    case "${flag}" in
    o) output_flag="${OPTARG}" ;;
    q) quality_flag="${OPTARG}" ;;
    *) print_usage
        exit 1 ;;
    esac
done

dateTime=$(date '+%m_%d_%Y_%H-%M-%S');
output=$dateTime
if [ -z $output_flag ]
    then
    output=$dateTime
else
    output=$output_flag
fi

adb shell screenrecord /sdcard/$output.mp4 &
PID=$!

echo "-- Press enter when done recording --"
read

echo " -- Ending recording..."
kill $PID &> /dev/null
wait $PID &>/dev/null
sleep 1

echo "-- Pulling mp4 from device --"
adb pull /sdcard/$output.mp4 &> /dev/null

echo " -- Converting mp4 to gif -- "
if [ $quality_flag == 'h' ]
    then
    ffmpeg -i $output.mp4 -vf "fps=10,scale=360:-1,split[s0][s1];[s0]palettegen[p];[s1][p]paltetteuse" $output.gif -loglevel quiet
elif [ $quality_flag == 'f' ]
    then
    ffmpeg -i $output.mp4 -vf "fps=10" $output.gif -loglevel quiet
else 
    ffmpeg -i $output.mp4 -vf "fps=10,scale=240:-1:flags=lanczos" $output.gif -loglevel quiet
fi

echo " -- Cleaning up... -- "
rm $output.mp4
echo " -- Done - $output.gif created"
