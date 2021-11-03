{ config, lib, pkgs, ... }:

{
  ## Kernel
  hardware.enableAllFirmware = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ## Network
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  ## Sound
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  ## Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluezFull;
  };

  ## Graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver # LIBVA_DRIVER_NAME=iHD to use this
      intel-ocl
    ];
  };
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  ## Video Driver for GUI
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "true"
      '';
    libinput = {
      enable = true;
      middleEmulation = true;
    };
  };

  ## CPU
  nix.maxJobs = lib.mkDefault 4;
  powerManagement = {
      ## TODO: Change to "powersave" when not connected to power
    cpuFreqGovernor = lib.mkDefault "performance";
    powertop.enable = true;
  };


}