{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  environment.pathsToLink = [ "/share/doc" ];
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.antialias = true;
    fontconfig.enable = true;
    fontconfig.hinting.autohint = false;
    fontconfig.hinting.enable = true;
    fontconfig.hinting.style = "slight";
    fontconfig.includeUserConf = false;
    fontconfig.subpixel.lcdfilter = "default";
    fontconfig.subpixel.rgba = "rgb";
    fontconfig.ultimate.enable = true;
    fonts = with pkgs; [
      mplus-outline-fonts
      terminus_font
    ];
  };

  networking.connman.enable = true;

  services.xserver = {
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.desktopManagerHandlesLidAndPower = false;
    displayManager.lightdm.enable = true;
    enable = true;
    layout = "us";
    windowManager.default = "xsession";
    windowManager.session =
      [ { name = "xsession";
          start = ''
            $HOME/.xsession
            waitPID=$!
          '';
        }
      ];
  };
}
