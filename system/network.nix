
{ config, pkgs, ... }:

{

  imports =
    [
      ../modules/wifi-passwords.nix
      ../secrets/wifi.nix
    ];

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

}