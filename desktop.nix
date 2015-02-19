{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    compton-git
    dmenu
    dunst
    firefoxWrapper
    gmrun
    haskellEnv
    i3lock
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

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  services.xserver = {
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.desktopManagerHandlesLidAndPower = false;
    displayManager.slim.enable = true;
    displayManager.slim.theme = pkgs.fetchurl {
      url = "https://github.com/jagajaga/nixos-slim-theme/archive/Final.tar.gz";
      sha256 = "4cab5987a7f1ad3cc463780d9f1ee3fbf43603105e6a6e538e4c2147bde3ee6b";
    };
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

  time.timeZone = "America/New_York";

  users.extraUsers.ht = {
    createHome = true;
    description = "Henry Till";
    extraGroups = [ "wheel" ];
    group = "users";
    home = "/home/ht";
    uid = 1000;
    useDefaultShell = true;
  };
}
