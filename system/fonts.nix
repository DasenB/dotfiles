{ config, lib, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      inconsolata
      font-awesome_4
      google-fonts
      freefont_ttf
      terminus_font
      corefonts
      dejavu_fonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      noto-fonts-emoji
      source-code-pro
      libertinus
      libertine
      profont
      liberation_ttf
      ubuntu_font_family
    ];
    enableDefaultFonts = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Linux Libertine" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "Inconsolata" "FontAwesome" ];
      };
      localConf = ''
        <?xml version='1.0'?>
        <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
        <fontconfig>
          <alias>
            <family>sans</family>
            <prefer><family>DejaVu Sans</family></prefer>
          </alias>
        </fontconfig>
      '';
      includeUserConf=false;
    };
  };
}