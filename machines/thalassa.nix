{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
    ];

  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  ht.conky.enable = true;

  networking.hostName = "thalassa";

  services.xserver.xkbOptions = "ctrl:nocaps";
}
