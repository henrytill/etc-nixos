{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
    ];

  boot.cleanTmpDir = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "tethys";
}
