#!/bin/sh

script_path=`dirname $0`
git pull
sudo cp -r $script_path /etc/nixos/