#/usr/bin/env bash
export DISPLAY=":1"
export WINEDEBUG="-all"
export WINEPREFIX="/root/.wine"

current_dir=$(dirname $0)


set +e

echo "Starting Xvfb on ${DISPLAY}"
Xvfb $DISPLAY -screen 0 1024x768x16 &
xvfbpid=$!
echo "Display started PID ${xvfbpid}."

cp $current_dir/*.iss $WINEPREFIX/drive_c/

echo "Running install step 1..."
step=1 wine "$current_dir/wic_server_1010.exe"  /s /f1"C:\\wic_server_1010.exe.iss" &
sleep 20 
# xwd -root -silent | convert xwd:- png:/tmp/wicds/step-1.1.png 
xdotool key Tab Tab a Return 
# xwd -root -silent | convert xwd:- png:/tmp/wicds/step-1.2.png 
wait %step=1

echo "Running install step 2..."
step=2 wine "$current_dir/wic_server_update_1010_to_1011.exe"  /s /f1"C:\\wic_server_update_1010_to_1011.exe.iss" &
sleep 20 
# xwd -root -silent | convert xwd:- png:/tmp/wicds/step-2.1.png 
xdotool key Tab Tab a Return 
# xwd -root -silent | convert xwd:- png:/tmp/wicds/step-2.2.png 
wait %step=2

unzip -o "$current_dir/wic_server_patch_beta.zip" -d $WINEPREFIX/drive_c/Program\ Files/WICDS

rm -f /root/.wine/drive_c/*.iss

echo "Killing the display..."
kill $xvfbpid || true
echo "Display killed."

echo "Done."