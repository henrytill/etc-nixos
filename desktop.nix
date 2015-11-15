{ config, pkgs, ... }:

let

  dwm-HEAD = pkgs.callPackage ./pkgs/dwm {};

in {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    conky
    (dmenu.override { enableXft = true; })
    dunst
    dwm-HEAD
    firefoxWrapper
    ghostscript
    graphviz
    i3lock
    libnotify
    mupdf
    rxvt_unicode_with-plugins
    xsel
    xlibs.xmodmap
  ];

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
          start = "";
        }
      ];
  };
}
