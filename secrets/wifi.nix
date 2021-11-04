{ config, lib, pkgs, ... }:

{
    networking.networkmanager.networks.NETWORK = {
      psk = "";
      autoconnect = true;
      priority = 1;
    };
}