#!/bin/bash
echo Start
fname=${PWD##*/}
mkdir -v renamed
counter=1
ls -1tr *.JPG | while read filename; do cp $filename renamed/$(printf %05d $counter)_$filename; ((counter++)); done

cd renamed

mkdir -v resized
echo "Resize pictures"
mogrify -path resized -resize 1920x1080! *.JPG
echo "Resize Done"
cd resized

echo make a video
ffmpeg -r 25 -pattern_type glob -i '*.JPG' -c:v copy "${fname}.avi"
#echo "decode video"
#ffmpeg -i "${fname}.avi" -c:v libx264 -preset slow -crf 15 "${fname}-final.avi"
#echo "short video for Instagram"
#ffmpeg -i "${fname}-final.avi" -filter:v "setpts=0.3*PTS" "${fname}-short.avi"
echo move files 
mv -v "${fname}.avi" ../../"${fname}.avi"
#mv -v "${fname}-short.avi" ../../"${fname}-short.avi"
#mv -v "${fname}-final.avi" ../../"${fname}-final.avi"
echo End!!! happy TimeLapse
##add music
#ffmpeg -i output-short.mp4 -i HAPPYDRUNKFACE\ -\ Rassveti.mp3 -codec copy -shortest output-short-music.mp4
