{ config, lib, pkgs, ... }:

with lib;

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
      ../secrets/thaumas.nix
    ];

  boot =
    let
      linux_chromebook = pkgs.linux.override
        { extraConfig = "CHROME_PLATFORMS y\n"; };
    in rec {
      cleanTmpDir = true;
      kernelPackages = pkgs.recurseIntoAttrs
        (pkgs.linuxPackagesFor linux_chromebook kernelPackages);
      kernelParams = [ "modprobe.blacklist=ehci_pci" ];
      loader.grub.device = "/dev/sda";
      loader.grub.enable = true;
    };

  fileSystems."/".options = concatStringsSep "," [
    "ssd"
    "space_cache"
    "compress-force=zlib"
    "noatime"
  ];

  networking.hostName = "thaumas";

  services.acpid.enable = true;
  services.logind.extraConfig = "HandlePowerKey=ignore";
  services.redshift = {
    enable = true;
    latitude = "42";
    longitude = "71";
  };
  services.xserver = {
    synaptics.enable = true;
    synaptics.palmDetect = true;
    synaptics.tapButtons = false;
    synaptics.twoFingerScroll = true;
  };

  sound.extraConfig = ''
    defaults.pcm.!card PCH
    defaults.pcm.!device 0
  '';
}
