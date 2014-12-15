{ config, pkgs, ... }:

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
      ${pkgs.xorg.xrdb}/bin/xrdb "${pkgs.writeText "xrdb.config" ''
        Xft.antialias: true
        Xft.autohint: false
        Xft.dpi: 120
        Xft.hinting: true
        Xft.hintstyle: hintslight
        Xft.lcdfilter: lcddefault
        Xft.rgba: rgb

        URxvt.cursorBlink: true
        URxvt.saveLines: 4096
        URxvt.scrollBar: false
        URxvt.scrollTtyKeypress: true
        URxvt.scrollTtyOutput: false
        URxvt.scrollWithBuffer: true
        URxvt.termName: xterm-256color

        URxvt.perl-ext: default,url-select
        URxvt.keysym.M-u: perl:url-select:select_next
        URxvt.url-select.launcher: /run/current-system/sw/bin/xdg-open
        URxvt.url-select.underline: true

        URxvt.font: xft:Source Code Pro:pixelsize=13
        URxvt.boldFont: xft:Source Code Pro:style=Bold:pixelsize=13
        Emacs.font: Source Code Pro:pixelsize=13

        !!!! Solarized
        #define S_yellow        #b58900
        #define S_orange        #cb4b16
        #define S_red           #dc322f
        #define S_magenta       #d33682
        #define S_violet        #6c71c4
        #define S_blue          #268bd2
        #define S_cyan          #2aa198
        #define S_green         #859900

        !!! Dark
        ! #define S_base03        #002b36
        ! #define S_base02        #073642
        ! #define S_base01        #586e75
        ! #define S_base00        #657b83
        ! #define S_base0         #839496
        ! #define S_base1         #93a1a1
        ! #define S_base2         #eee8d5
        ! #define S_base3         #fdf6e3

        !!! Light
        #define S_base03        #fdf6e3
        #define S_base02        #eee8d5
        #define S_base01        #93a1a1
        #define S_base00        #839496
        #define S_base0         #657b83
        #define S_base1         #586e75
        #define S_base2         #073642
        #define S_base3         #002b36

        URxvt*background:              S_base03
        URxvt*foreground:              S_base0
        URxvt*fading:                  40
        URxvt*fadeColor:               S_base03
        URxvt*cursorColor:             S_base1
        URxvt*pointerColorBackground:  S_base01
        URxvt*pointerColorForeground:  S_base1

        URxvt*color0:                  S_base02
        URxvt*color1:                  S_red
        URxvt*color2:                  S_green
        URxvt*color3:                  S_yellow
        URxvt*color4:                  S_blue
        URxvt*color5:                  S_magenta
        URxvt*color6:                  S_cyan
        URxvt*color7:                  S_base2
        URxvt*color9:                  S_orange
        URxvt*color8:                  S_base03
        URxvt*color10:                 S_base01
        URxvt*color11:                 S_base00
        URxvt*color12:                 S_base0
        URxvt*color13:                 S_violet
        URxvt*color14:                 S_base1
        URxvt*color15:                 S_base3
      ''}"
      xset b off
      xsetroot -solid "#eee8d5" -cursor_name left_ptr
      xscreensaver -no-splash &
      unclutter -idle 1 &
      nm-applet &
    '';
    enable = true;
    layout = "us";
    windowManager.default = "xmonad";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
  };

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
