{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
    ];

  boot.cleanTmpDir = true;
  boot.kernelParams = [ "modprobe.blacklist=ehci_pci" ];
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.enable = true;

  networking.hostName = "thaumas";

  nixpkgs.config = {
    packageOverrides = super: let self = super.pkgs; in {
      linux = super.linux.override { extraConfig = "CHROME_PLATFORMS y\n"; };
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
