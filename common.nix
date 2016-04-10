{ config, lib, pkgs, ... }:

with lib;

{
  imports = import ./modules/module-list.nix;

  environment.systemPackages = with pkgs; [
    activator
    aspell
    aspellDicts.en
    boot
    cryptsetup
    ctags
    ed
    emacs
    file
    gnumake
    gnupg
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.ghc
    htop
    jdk
    jshon
    leiningen
    lsof
    maven
    mr
    ncdu
    nix-repl
    nodejs
    pandoc
    phantomjs2
    rlwrap
    sbt
    scrot
    stow
    tmux
    tree
    unzip
    vim
    wget
  ] ++ (if config.services.xserver.enable then [
    gitAndTools.gitFull
  ] else [
    (gitAndTools.gitFull.override { guiSupport = false; })
    (pinentry.override { gtk2 = null; })
  ]);

  environment.variables.JAVA_HOME = "${pkgs.jdk}/lib/openjdk";

  nix.useChroot = true;

  nixpkgs.config = {

    allowUnfree = true;

    firefox.enableGoogleTalkPlugin = true;

    packageOverrides = pkgs: with pkgs; {
      emacs = pkgs.emacs.overrideDerivation (oldAttrs: {
        postInstall = oldAttrs.postInstall + ''
          rm $out/bin/{ctags,etags}
          rm $out/share/man/man1/{ctags,etags}.1.gz
        '';
      });
    };
  };

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
