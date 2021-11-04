{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.networking.networkmanager;

  getFileName = stringAsChars (x: if x == " " then "-" else x);

  createWifi = ssid: opt: {
    name = ''
      NetworkManager/system-connections/${getFileName ssid}.nmconnection
    '';
    value = {
      mode = "0400";
      source = pkgs.writeText "${ssid}.nmconnection" ''
        [connection]
        id=${ssid}
        type=wifi
        autoconnect=${if opt.autoconnect then "TRUE" else "FALSE" }
        autoconnect-priority=${opt.priority}

        [wifi]
        ssid=${ssid}

        [wifi-security]
        ${optionalString (opt.psk != null) ''
        key-mgmt=wpa-psk
        psk=${opt.psk}''}
      '';
    };
  };

  keyFiles = mapAttrs' createWifi config.networking.networkmanager.networks;
in {

  options = {
    networking.networkmanager = {
      networks = mkOption {
        type = types.attrsOf (types.submodule {
          options = {
            psk = mkOption {
              type = types.nullOr types.str;
              default = null;
              description = ''
                    The network's pre-shared key in plaintext defaulting
                    to being a network without any authentication.
                    Be aware that these will be written to the nix store
                    in plaintext!
                  '';
            };
            autoconnect = mkOption {
              type = types.bool;
              default = true;
              description = ''
                    Set this to <literal>false</literal> to prevent NetworkManager
                    from automaticly connecting to this network.
                  '';
            };
            priority = mkOption {
              type = types.int;
              default = 0;
              description = ''
                    When connecting automaticly networks with a higher priority are prevered 
                    over networks with lower priority.
                  '';
            };
          };
        });
      };
    };
  };

  config = mkIf cfg.enable {
    environment.etc = keyFiles;

    systemd.services.NetworkManager-predefined-connections = {
      restartTriggers = mapAttrsToList (name: value: value.source) keyFiles;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.coreutils}/bin/true";
        ExecReload = "${pkgs.networkmanager}/bin/nmcli connection reload";
      };
      reloadIfChanged = true;
      wantedBy = [ "multi-user.target" ];
    };
  };
}