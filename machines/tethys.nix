{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../common.nix
      ../desktop.nix
      ../development.nix
    ];

  boot.cleanTmpDir = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/".options = "defaults,noatime";

  ht.conky.enable = true;

  networking.enableIPv6 = false;
  networking.hostName = "tethys";
}
