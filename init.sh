#!/usr/bin/env bash

curl --create-dirs --output-dir context/install_files -O https://www.massgate.org/files/wic_server_1010.exe > context/install_files/wic_server_1010.exe
curl --create-dirs --output-dir context/install_files -O https://www.massgate.org/files/wic_server_update_1010_to_1011.exe > context/install_files/wic_server_update_1010_to_1011.exe
curl --create-dirs --output-dir context/install_files -O https://www.massgate.org/files/wic_server_patch_beta.zip > context/install_files/wic_server_patch_beta.zip
curl -O https://www.massgate.org/files/maps/map_pack.zip

mkdir -p config/maps
unzip -o map_pack.zip -d config/maps
rm -f map_pack.zip