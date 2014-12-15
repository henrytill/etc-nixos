{ config, pkgs, ... }:

{
  imports = [ ../desktop.nix ];

  boot.cleanTmpDir = true;

  deployment.targetEnv = "virtualbox";
  deployment.virtualbox.memorySize = 2048;

  networking.hostName = "tethys";

  services.virtualboxGuest.enable = true;
  services.xserver.videoDrivers = [ "virtualbox" ];

  users.extraUsers.ht.extraGroups = [ "docker" ];

  virtualisation.docker.enable = true;
}
