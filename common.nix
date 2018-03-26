{ config, lib, pkgs, ... }:

with lib;

{
  imports = import ./modules/module-list.nix;

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    ctags
    file
    gnumake
    gnupg
    git
    htop
    lsof
    mercurial
    mr
    ncdu
    nix-repl
    rlwrap
    scrot
    stow
    tmux
    tree
    unzip
    vim_configurable
    wget
  ];

  environment.variables.EDITOR = "vim";

  nix.useSandbox = true;

  nixpkgs.config = {

    allowUnfree = true;

    packageOverrides = pkgs: with pkgs; {

      connman = pkgs.connman.overrideDerivation (oldAttr: {
        patches = [
          (pkgs.fetchpatch {
            name = "header-include.patch";
            url = "https://git.kernel.org/pub/scm/network/connman/connman.git/patch/?id=bdfb3526466f8fb8f13d9259037d8f42c782ce24";
            sha256 = "0q6ysy2xvvcmkcbw1y29x90g7g7kih7v95k1xbxdcxkras5yl8nf";
          })
        ];
      });
    };
  };

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.zsh.enable = true;

  services.openssh.enable = true;

  time.timeZone = "America/New_York";

  users.extraUsers.ht = {
    createHome = true;
    description = "Henry Till";
    extraGroups = [ "wheel" ];
    group = "users";
    home = "/home/ht";
    shell = "/run/current-system/sw/bin/zsh";
    uid = 1000;
  };
}
