
{ config, pkgs, ... }:

{

  imports =
    [
      ../modules/wifi-password.nix
      ../secrets/wifi.nix
    ];

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "wpa_supplicant";

}