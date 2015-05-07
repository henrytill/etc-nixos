{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../headless.nix
    ];

  boot.cleanTmpDir = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  environment.systemPackages = with pkgs; [
    jack2
    qjackctl
  ];

  fileSystems."/".options = "defaults,noatime";

  networking.enableIPv6 = false;
  networking.hostName = "glaucus";

  musnix.enable = true;
  musnix.kernel.optimize = true;
  musnix.kernel.realtime = true;
  musnix.rtirq.enable = true;
  musnix.rtirq.highList = "timer";
  musnix.soundcardPciId = "00:05.0";

  programs.ssh.forwardX11 = true;
  programs.ssh.setXAuthLocation = true;

  users.extraUsers.ht.extraGroups = [ "audio" ];
}
