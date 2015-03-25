{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.emacs;
in
{
  options = {
    programs.emacs = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      defaultEditor = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      if config.services.xserver.enable
        then [ pkgs.emacs ]
        else [ pkgs.emacs24-nox ];
    environment.variables = mkIf cfg.defaultEditor {
      EDITOR = mkOverride 0 "emacsclient -t --alternate-editor=";
    };
  };
}
