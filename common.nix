{ config, lib, pkgs, ... }:

with lib;

{
  imports = import ./modules/module-list.nix;

  environment.etc."bashrc.local".text = ''
    if [ -z "$IN_NIX_SHELL" ]; then
        printf "\e]0;$USER@$HOSTNAME:\a"

        update_title () {
            printf "\e]0;$USER@$HOSTNAME: $BASH_COMMAND\a"
        }

        case "$TERM" in
        xterm*|rxvt*)
            trap update_title DEBUG
            ;;
        esac
    fi
  '';

  environment.systemPackages = with pkgs; [
    debootstrap
    file
    gnumake
    gnupg1compat
    htop
    iftop
    iotop
    lsof
    mr
    mosh
    obnam
    sshfsFuse
    stow
    tmux
    tree
    unzip
    wget
    xz
  ] ++ (if config.services.xserver.enable then
    [ gitAndTools.gitFull ]
  else
    [ (gitAndTools.gitFull.override { guiSupport = false; })
      (pinentry.override { useGtk = false; })
    ]);

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
      e = "$EDITOR";
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

  programs.emacs.enable = true;
}
