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
    jack2Full
  ];

  fileSystems."/".options = "defaults,noatime";

  networking.enableIPv6 = false;
  networking.hostName = "glaucus";

  musnix.enable = true;
  musnix.kernel.optimize = true;
  musnix.kernel.realtime = true;
  musnix.kernel.packages = pkgs.linuxPackages_4_1_rt;
  musnix.rtirq.enable = true;
  musnix.rtirq.highList = "timer";
  musnix.soundcardPciId = "00:05.0";

  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
    emacs = super.emacs24-nox;
  };

  users.extraUsers.ht.extraGroups = [ "audio" ];
}
