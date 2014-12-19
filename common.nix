{ config, lib, pkgs, ... }:

with lib;

{
  imports = import ./modules/module-list.nix;

  environment.etc."bashrc.local".text = ''
    printf "\033]0;$USER@$HOSTNAME:\007"

    update_title () {
        printf "\033]0;$USER@$HOSTNAME: $BASH_COMMAND\007"
    }

    case "$TERM" in
    xterm*|rxvt*)
        trap update_title DEBUG
        ;;
    esac
  '';

  environment.systemPackages = with pkgs; [
    debootstrap
    file
    gitAndTools.gitFull
    htop
    iftop
    iotop
    lsof
    mr
    obnam
    sshfsFuse
    stow
    tmux
    tree
    unzip
    wget
    xz
    zile
  ];

  environment.variables =
    { EDITOR = mkOverride 0 "zile"; };

  nix.trustedBinaryCaches = [ "http://hydra.nixos.org" ];
  nix.useChroot = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = import ./overrides;
  };

  programs.bash = {
    interactiveShellInit = ''
      p() {
          clear
          echo 'Current Profile: ' && readlink "$HOME/.nix-profile"
          echo && echo 'Installed:' && nix-env -q
      }
    '';

    shellAliases = {
      htop = "TERM=xterm htop";
      l = "clear && pwd && ls -lh";
      la = "clear && pwd && ls -lah";
      lf = "ls -aF";
      ll = "ls -la";
      llt = "ls -lat";
      ls = "ls --color=tty";
      lt = "ls -lt";
      restart = "systemctl restart";
      start = "systemctl start";
      status = "systemctl status";
      stop = "systemctl stop";
      u = "cd .. && l";
      which = "type -P";
    };
  };
}
