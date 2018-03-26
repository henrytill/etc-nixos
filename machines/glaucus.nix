{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../common.nix
    ];

  boot.cleanTmpDir = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  environment.systemPackages = with pkgs; [
    jack2Full
    rxvt_unicode.terminfo
  ];

  fileSystems."/".options = [ "defaults" "noatime" ];

  networking.enableIPv6 = false;
  networking.hostName = "glaucus";

  musnix.enable = true;
  musnix.kernel.optimize = true;
  musnix.kernel.realtime = true;
  musnix.kernel.packages = pkgs.linuxPackages_latest_rt;
  musnix.rtirq.enable = true;
  musnix.rtirq.highList = "timer";
  musnix.soundcardPciId = "00:05.0";

  programs.ssh.setXAuthLocation = true;
  services.openssh.forwardX11 = true;

  users.extraUsers.ht.extraGroups = [ "audio" ];
}
