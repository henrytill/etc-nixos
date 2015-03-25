{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  users.extraUsers.ht = {
    createHome = true;
    description = "Henry Till";
    extraGroups = [ "wheel" ];
    group = "users";
    home = "/home/ht";
    uid = 1000;
    useDefaultShell = true;
  };
}
