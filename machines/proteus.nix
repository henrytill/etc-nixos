{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../common.nix
    ];

  boot.cleanTmpDir = true;
  boot.extraModprobeConfig = "options iwlwifi led_mode=1";
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.enable = true;

  environment.systemPackages = with pkgs; [
    acpi
    arandr
    lm_sensors
    vagrant
  ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  networking = {
    hostName = "proteus";
    networkmanager.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  services.acpid.enable = true;
  services.openssh.enable = true;
  services.synergy.client = {
    enable = true;
    screenName = "proteus";
    serverAddress = "ht-mac-mini";
  };
  services.thinkfan.enable = true;
  services.virtualboxHost.enable = true;
  services.xserver = {
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;
    displayManager.sessionCommands = ''
      xset b off
      xsetroot -solid "#eee8d5" -cursor_name left_ptr
      xscreensaver -no-splash &
      unclutter -idle 1 &
      nm-applet &
    '';
    enable = true;
    layout = "us";
    synaptics.enable = true;
    windowManager.default = "xmonad";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    xkbOptions = "ctrl:nocaps";
  };

  time.timeZone = "America/New_York";

  users.extraUsers.ht = {
    createHome = true;
    description = "Henry Till";
    extraGroups = [ "wheel" "networkmanager" "vboxusers" ];
    group = "users";
    home = "/home/ht";
    useDefaultShell = true;
  };

}
