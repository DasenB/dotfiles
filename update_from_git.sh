#!/bin/sh

script_path=`dirname $0`
git pull
sudo cp -R /etc/nixos/dotfiles/secrets/* $script_path/secrets/
sudo cp -R $script_path /etc/nixos/dotfiles
sudo chown -R bjarne:users $script_path
sudo nixos-rebuild switch