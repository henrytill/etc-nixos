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
    gmrun
    gnome3.dconf
    gnome3.gnome_icon_theme
    gnome3.gnome_themes_standard
    gtk-engine-murrine
    libnotify
    networkmanagerapplet
    rxvt_unicode_with-plugins
    scrot
    stalonetray
    unclutter
    urxvt_perls
    xclip
    xscreensaver
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

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  services.xserver = {
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb ${xdefaults}
      ${pkgs.xorg.xset}/bin/xset b off
      ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "#eee8d5" -cursor_name left_ptr
      ${pkgs.xscreensaver}/bin/xscreensaver -no-splash &
      ${pkgs.unclutter}/bin/unclutter -idle 1 &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
    '';
    enable = true;
    layout = "us";
    windowManager.default = "xmonad";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
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
