{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../common.nix
    ];

  boot.cleanTmpDir = true;
  boot.kernel.sysctl = { "vm.swappiness" = 10; };
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.enable = true;

  fileSystems."/".options = "defaults,noatime";
  
  networking = {
    hostName = "wintermute";
    networkmanager.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  services.virtualbox.enable = true;
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
