{ config, lib, pkgs, ... }:

{
    networking.wireless.networks.NETWORK = {
      psk = "";
      autoconnect = {
        enable = true;
        priority = 1;
      };
    };
}