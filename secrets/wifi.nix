{ config, lib, pkgs, ... }:

{
    networking.wireless.networks.NETWORK = {
      psk = "";
      # autoconnectEnable = true;
      # autoconnectPriority = 1;
    };
}