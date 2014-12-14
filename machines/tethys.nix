{ config, pkgs, ... }:

{
  imports = [ ../common.nix ];

  boot.cleanTmpDir = true;

  deployment.targetEnv = "virtualbox";
  deployment.virtualbox.memorySize = 2048;

  networking = {
    hostName = "tethys";
    networkmanager.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  services.virtualboxGuest.enable = true;
  services.xserver = {
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;
    displayManager.sessionCommands = ''
      [ -f ~/.profile ] && source ~/.profile
      xset b off
      xsetroot -solid "#eee8d5" -cursor_name left_ptr
      xscreensaver -no-splash &
      unclutter -idle 1 &
      nm-applet &
    '';
    enable = true;
    layout = "us";
    videoDrivers = [ "virtualbox" ];
    windowManager.default = "xmonad";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
  };

  time.timeZone = "America/New_York";

  users.extraUsers.ht = {
    createHome      = true;
    description     = "Henry Till";
    extraGroups     = [ "wheel" "networkmanager" "docker" ];
    group           = "users";
    home            = "/home/ht";
    useDefaultShell = true;
  };

  virtualisation.docker.enable = true;
}
