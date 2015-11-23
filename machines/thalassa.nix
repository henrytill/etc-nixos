{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
    ];

  boot.initrd.availableKernelModules = [ "uas" ];
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs = {
    forceImportAll = false;
    forceImportRoot = false;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  fileSystems."/mnt/vms" = {
    device = "ext/vms";
    fsType = "zfs";
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  ht.conky.enable = true;

  networking.hostName = "thalassa";
  networking.hostId = "91855dd5";

  services.xserver.xkbOptions = "ctrl:nocaps";

  virtualisation.virtualbox.host.enable = true;
}
