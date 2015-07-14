{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
    ];

  boot.cleanTmpDir = true;
  boot.kernelPackages = pkgs.linuxPackages_3_18;
  boot.kernelParams = [ "modprobe.blacklist=ehci_pci" ];
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.enable = true;

  networking.hostName = "thaumas";

  nixpkgs.config = {
    packageOverrides = pkgs: {
      linux_3_18 = pkgs.linux_3_18.override { extraConfig = "CHROME_PLATFORMS y\n"; };
    };
  };

  services.acpid.enable = true;
  services.xserver = {
    synaptics.enable = true;
    synaptics.palmDetect = true;
    synaptics.tapButtons = false;
    synaptics.twoFingerScroll = true;
  };
}
