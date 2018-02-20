{ config, pkgs, ... }:

let

  dwm-HEAD = pkgs.callPackage ./pkgs/dwm {};

in {
  environment.systemPackages = with pkgs; [
    chromium
    dmenu
    dunst
    dwm-HEAD
    i3lock
    libnotify
    mpv
    mupdf
    xsel
    xterm
    zeal
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      defaultFonts.monospace = [ "Fira Mono" ];
      defaultFonts.sansSerif = [ "Fira Sans" ];
      ultimate.enable = true;
    };
    fonts = with pkgs; [
      fira
      fira-mono
      font-droid
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
