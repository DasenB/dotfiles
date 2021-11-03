{ config, lib, pkgs, ... }:

{
  ## System
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";

  ## Console
  console.keyMap = "de";

  ## Desktopmanager
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "eurosign:e";
  
}