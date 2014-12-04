{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    debootstrap
    dmenu
    dunst
    file
    gitAndTools.gitFull
    gitAndTools.gitAnnex
    gmrun
    gnome3.dconf
    gnome3.gnome_icon_theme
    gnome3.gnome_themes_standard
    gtk-engine-murrine
    htop
    iftop
    iotop
    libnotify
    lsof
    networkmanagerapplet
    rxvt_unicode
    scrot
    sshfsFuse
    stalonetray
    unclutter
    unzip
    xclip
    xscreensaver
    zile
  ];

  fonts = {
    enableFontConfig = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      liberation_ttf
      terminus_font
      ubuntu_font_family
    ];
  };

  nix.useChroot = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

}
