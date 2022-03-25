#!/usr/bin/env bash

FF_DIR=./dependencies/FF
FD_DIR=./dependencies/FD

FF_EXECUTABLE="${FF_DIR}/ff"
FD_EXECUTABLE="${FD_DIR}/builds/release/bin/downward"
FD_TRANSLATE="${FD_DIR}/builds/release/bin/translate/translate.py"

cat ./requirements.system | xargs sudo apt-get install -y
cat ./requirements.pip | xargs pip3 install

if [[ -f "$FF_EXECUTABLE" ]]; then
  echo "FF already exists."
else
  cd $FF_DIR
  make
  chmod +x ff
  cd ../../
fi

if [[ -f "$FD_EXECUTABLE" ]] && [[ -f "$FD_TRANSLATE" ]]; then
  echo "FD already exists."
else
  cd $FD_DIR
  chmod +x build.py
  ./build.py
  cd ../../
fi
