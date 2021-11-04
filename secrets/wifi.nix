{ config, lib, pkgs, ... }:

{
    imports =
    [
      ../modules/wifi-passwords.nix
    ];

    networking.networkmanager.networks.NETWORK = {
      psk = "";
      autoconnect = true;
      priority = 1;
    };
}