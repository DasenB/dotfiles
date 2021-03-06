{ config, pkgs, ... }:

{
  imports =
    [
     ./system/hardware.nix
     ./system/network.nix
     ./system/localisation.nix
     ./system/fonts.nix
     ./system/packages.nix
     ./system/printer.nix
    ];

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos-desktop";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.enp6s0u1u3u3.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  
  nixpkgs.config.allowUnfree = true;
  
  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "Lat2-Terminus16";


  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
   
    displayManager = {
        defaultSession = "xfce+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };


  # # Printer and Scanner
  # services.printing = {
  #   enable = true;
  #   drivers = [ pkgs.gutenprint pkgs.epson-escpr pkgs.hplipWithPlugin];
  # };
  
  # hardware.sane = {
  #   enable = true;
  #   extraBackends = [pkgs.sane-airscan ];
  # };

  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  # };
  
  
  # Configure keymap in X11
  # services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ???passwd???.
  users.users.bjarne = {
    isNormalUser = true;
    extraGroups = [ "wheel" "scanner" "lp" ]; # Enable ???sudo??? for the user.
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    sublime3
    rstudio
    thunderbird-91
    vscode
    jetbrains.clion
    jetbrains.goland
    jetbrains.webstorm
    tdesktop
    texstudio
    cura
    keepassx2
    virtualbox
    docker
    git
    home-manager
    gnome.simple-scan
    gnome.eog
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It???s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}