{ config, lib, pkgs, ... }:

{
    networking.wireless.networks.NETWORK = {
      psk = "";
      priority = 1;
    };
}