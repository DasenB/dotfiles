{ config, lib, pkgs, ... }:

{

  # TODO: Propbably not finishes. Compare to example.
  # nixpkgs.config = import ../pkgs/nixpkgs-config.nix;
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  programs.bash.enableCompletion = true;
  programs.ssh.askPassword = "${pkgs.ksshaskpass}/bin/ksshaskpass";

}