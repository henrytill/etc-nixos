{ config, lib, pkgs, ... }:

with lib;

{
  imports = import ./modules/module-list.nix;

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
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
    weechat
    wget
    xz
    zile
  ] ++ (if config.services.xserver.enable then [
    gitAndTools.gitFull
  ] else [
    (gitAndTools.gitFull.override { guiSupport = false; })
    (pinentry.override { useGtk = false; })
  ]);

  environment.variables = {
    ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
  };

  nix.trustedBinaryCaches = [ "http://hydra.nixos.org" ];
  nix.useChroot = true;

  nixpkgs.config = import ./nixpkgs/config.nix;

  programs.zsh.enable = true;

  programs.emacs.enable = true;

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
}
