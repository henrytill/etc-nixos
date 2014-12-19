{ config, pkgs, ... }:

let

  xdefaults = pkgs.substituteAll {
    name = "xrbd.config";
    src = ./settings/xrdb.config;

    inherit (pkgs) xdg_utils;
  };

in

{
  imports = [ ./common.nix ];

  environment.systemPackages = with pkgs; [
    dmenu
    dunst
    firefoxWrapper
    gmrun
    gnome3.dconf
    gnome3.gnome_icon_theme
    gnome3.gnome_themes_standard
    gtk-engine-murrine
    i3status
    libnotify
    mupdf
    networkmanagerapplet
    rxvt_unicode_with-plugins
    scrot
    unclutter
    urxvt_perls
    xclip
    xscreensaver
    youtube-dl
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.antialias = true;
    fontconfig.defaultFonts.monospace = [ "Source Code Pro" ];
    fontconfig.defaultFonts.sansSerif = [ "Source Sans Pro" ];
    fontconfig.defaultFonts.serif = [ "Source Serif Pro" ];
    fontconfig.enable = true;
    fontconfig.hinting.autohint = false;
    fontconfig.hinting.enable = true;
    fontconfig.hinting.style = "slight";
    fontconfig.includeUserConf = false;
    fontconfig.subpixel.lcdfilter = "default";
    fontconfig.subpixel.rgba = "rgb";
    fontconfig.ultimate.enable = false;
    fonts = with pkgs; [
      dejavu_fonts
      liberation_ttf
      source-code-pro
      source-sans-pro
      source-serif-pro
      terminus_font
      ubuntu_font_family
    ];
  };

  networking.networkmanager.enable = true;

  nixpkgs.config = {
    dmenu.enableXft = true;
    firefox = {
      enableAdobeFlash = true;
      enableGoogleTalkPlugin = true;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  services.xserver = {
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.slim.enable = true;
    displayManager.slim.theme = pkgs.fetchurl {
      url = "https://github.com/jagajaga/nixos-slim-theme/archive/Final.tar.gz";
      sha256 = "4cab5987a7f1ad3cc463780d9f1ee3fbf43603105e6a6e538e4c2147bde3ee6b";
    };
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb ${xdefaults}
      ${pkgs.xorg.xset}/bin/xset b off
      ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "#93a1a1"
      ${pkgs.xscreensaver}/bin/xscreensaver -no-splash &
      ${pkgs.unclutter}/bin/unclutter -idle 1 &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
    '';
    enable = true;
    layout = "us";
    windowManager.default = "i3";
    windowManager.i3.enable = true;
  };

  sound.godMode.enable = false;

  time.timeZone = "America/New_York";

  users.extraUsers.ht = {
    createHome = true;
    description = "Henry Till";
    extraGroups = [ "wheel" "networkmanager" ];
    group = "users";
    home = "/home/ht";
    useDefaultShell = true;
  };
}
