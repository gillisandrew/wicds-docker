#!/usr/bin/env bash

wicds_install_dir="/root/.wine/drive_c/Program Files/WICDS"

cd "/config"
export WINEDEBUG="-all"

mkdir -p /config
rm -rf $wicds_install_dir/maps
cp -r /config/* "$wicds_install_dir"

xvfb-run -a wine "$wicds_install_dir/wic_ds.exe"
