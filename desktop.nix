{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  environment.pathsToLink = [ "/share/doc" ];
  environment.systemPackages = with pkgs; [
    dmenu
    dunst
    firefoxWrapper
    gmrun
    gimp
    haskellEnv
    hsetroot
    i3lock
    inkscape
    libnotify
    mupdf
    rxvt_unicode_with-plugins
    scrot
    tigervnc
    unclutter
    urxvt_perls
    vlc
    xclip
    xlibs.xmessage
    youtube-dl
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
    windowManager.default = "xmonad";
    windowManager.session =
      [ { name = "xmonad";
          start = ''
            ${pkgs.haskellEnv}/bin/xmonad &
            waitPID=$!
          '';
        }
      ];
  };
}
