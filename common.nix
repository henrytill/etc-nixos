{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    debootstrap
    dmenu
    dunst
    file
    gitAndTools.gitAnnex
    gitAndTools.gitFull
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
    rxvt_unicode_with-plugins
    scrot
    sshfsFuse
    stalonetray
    unclutter
    unzip
    urxvt_perls
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

  nix.binaryCaches =
    [ "http://cache.nixos.org"
      "http://hydra.nixos.org"
    ];

  nix.useChroot = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; rec {
      dunst = stdenv.lib.overrideDerivation pkgs.dunst
        (oldAttrs: { patchPhase = null; });
    };
  };

}
