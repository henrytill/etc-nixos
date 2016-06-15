{ config, pkgs, ... }:

let

  conkyrc = pkgs.writeText "conkyrc" ''
    out_to_console yes
    out_to_x no
    background no
    update_interval 2
    total_run_times 0
    use_spacer left
    pad_percents 3

    TEXT
    ''${addr wlp2s0}   ''${fs_free /}   ''$memperc% ($mem)   ''${time %a %b %d %I:%M %P}
  '';

in {
  imports =
    [ ../hardware-configuration.nix
      ../common.nix
      ../desktop.nix
      ../development.nix
    ];

  boot.initrd.availableKernelModules = [ "uas" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs = {
    forceImportAll = false;
    forceImportRoot = false;
  };

  environment.systemPackages = with pkgs; [
    cmus
    dropbox-cli
    pavucontrol
    pciutils
    v4l_utils
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
  ht.conky.conkyrc = conkyrc;

  networking.firewall.allowedTCPPorts = [ 80 3000 3449 ];
  networking.firewall.allowPing = true;
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
