
{ config, pkgs, ... }:

{

  imports =
    [
      ./secrets/wifi.nix
    ];

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "wpa_supplicant";
}