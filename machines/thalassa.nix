{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
    ];

  boot.initrd.availableKernelModules = [ "uas" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs = {
    forceImportAll = false;
    forceImportRoot = false;
  };

  environment.pathsToLink = [ "/share/mozart" ];
  environment.systemPackages = with pkgs; [
    cmus
    dropbox-cli
    mozart-binary
    pavucontrol
    pciutils
    youtube-dl
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

  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.hostName = "thalassa";
  networking.hostId = "91855dd5";

  services.lighttpd.enable = true;
  services.lighttpd.cgit = {
    enable = true;
    configText = ''
      scan-path=/srv/git/
      enable-git-config=1
      repository-sort=age
    '';
  };

  services.xserver.xkbOptions = "ctrl:nocaps";

  users.extraUsers.ht.extraGroups = [ "docker" ];

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
}
