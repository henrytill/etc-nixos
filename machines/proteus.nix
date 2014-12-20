{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
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

  fileSystems."/".options = "defaults,noatime,discard";

  # fileSystems."/mnt/nereus" = {
  #   device = "nereus.home:/srv/nfs/";
  #   fsType = "nfs";
  # };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  networking.hostName = "proteus";

  services.acpid.enable = true;
  services.synergy.client = {
    autoStart = false;
    enable = true;
    screenName = "proteus";
    serverAddress = "nereus";
  };
  services.thinkfan.enable = true;
  services.virtualboxHost.enable = true;
  services.xserver = {
    synaptics.enable = true;
    synaptics.palmDetect = true;
    vaapiDrivers = [ pkgs.vaapiIntel ];
    xkbOptions = "ctrl:nocaps";
  };

  users.extraUsers.ht.extraGroups = [ "vboxusers" ];
}
