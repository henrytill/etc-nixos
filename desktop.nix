{ config, pkgs, ... }:

let

  dwm-HEAD = pkgs.callPackage ./pkgs/dwm {};

  texliveEnv = pkgs.texlive.combine {
    inherit (pkgs.texlive)
    scheme-medium
    collection-fontsextra
    collection-fontsrecommended
    enumitem
    fontaxes
    mweights
    titlesec;
  };

in {
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
    slack
    texliveEnv
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
      fira
      fira-mono
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
