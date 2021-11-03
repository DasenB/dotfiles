#!/bin/sh

script_path=`dirname $0`
git pull
sudo cp $script_path /etc/nixos/