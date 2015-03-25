{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../headless.nix
    ];

  boot.cleanTmpDir = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/".options = "defaults,noatime";

  networking.enableIPv6 = false;
  networking.hostName = "glaucus";

  musnix.enable = true;
  musnix.kernel.optimize = true;
  musnix.kernel.realtime = true;
}
