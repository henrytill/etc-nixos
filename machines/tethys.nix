{ config, pkgs, ... }:

{
  imports = [ ../desktop.nix ];

  boot.cleanTmpDir = true;

  networking.hostName = "tethys";

  services.virtualboxGuest.enable = true;
  services.xserver.videoDrivers = [ "virtualbox" ];

  users.extraUsers.ht.extraGroups = [ "docker" ];

  virtualisation.docker.enable = true;
}
