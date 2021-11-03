{ config, lib, pkgs, ... }:

{

  # Printer
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.epson-escpr pkgs.hplipWithPlugin];
  };
  
  # Scanner
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.sane-airscan ];
  };

  # Automatic detection of devices
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  
}