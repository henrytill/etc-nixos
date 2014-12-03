{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dmenu
    dunst
    emacs
    file
    firefoxWrapper
    gitAndTools.gitFull
    gitAndTools.gitAnnex
    gmrun
    gnome3.dconf
    gnome3.gnome_icon_theme
    gnome3.gnome_themes_standard
    gnupg1compat
    htop
    libnotify
    lm_sensors
    lsof
    mosh
    mr
    mupdf
    networkmanagerapplet
    obnam
    rxvt_unicode
    scrot
    sshfsFuse
    stalonetray
    stow
    tmux
    tree
    unclutter
    unzip
    xclip
    xscreensaver
    zile
  ];

  environment.variables.GTK_DATA_PREFIX="${pkgs.gnome3.gnome_themes_standard}";

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

    packageOverrides = pkgs: with pkgs; {

      mr = callPackage /home/ht/.nixpkgs/pkgs/mr/default.nix { };

    };
  };

}
