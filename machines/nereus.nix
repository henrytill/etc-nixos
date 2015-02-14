{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
    ];

  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  fileSystems."/".options = "defaults,noatime,discard";

  hardware.cpu.intel.updateMicrocode = true;

  networking.hostName = "nereus";

  services.xserver.xkbOptions = "ctrl:nocaps";
}
