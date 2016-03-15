{ config, pkgs, ... }:

let

  dwm-HEAD = pkgs.callPackage ./pkgs/dwm {};

in {
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    chromium
    dmenu
    dunst
    dwm-HEAD
    firefoxWrapper
    ghostscript
    graphviz
    i3lock
    libnotify
    mpv
    mupdf
    rxvt_unicode_with-plugins
    xsel
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      antialias = true;
      enable = true;
      hinting.autohint = false;
      hinting.enable = true;
      hinting.style = "slight";
      includeUserConf = false;
      subpixel.lcdfilter = "default";
      subpixel.rgba = "rgb";
      ultimate.enable = true;
    };
    fonts = with pkgs; [
      mplus-outline-fonts
    ];
  };

  networking.connman.enable = true;

  services.xserver = {
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;
    displayManager.sessionCommands = ''
      if test -f "$HOME/.zprofile"; then
          source "$HOME/.zprofile"
      fi

      ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "#222222"

      ${pkgs.xorg.xset}/bin/xset b off

      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    enable = true;
    layout = "us";
    windowManager.default = "dwm";
    windowManager.session =
      [ { name = "dwm";
          start = ''
            ${dwm-HEAD}/bin/dwm &
            waitPID=$!
          '';
        }
      ];
  };
}
