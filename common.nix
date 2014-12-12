{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    debootstrap
    dmenu
    dunst
    file
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

  nix.trustedBinaryCaches = [ "http://hydra.nixos.org" ];
  nix.useChroot = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; rec {
      dunst = stdenv.lib.overrideDerivation pkgs.dunst
        (oldAttrs: { patchPhase = null; });
    };
  };

}
