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
    weechat-minimal
    wget
    xz
    zile
  ] ++ (if config.services.xserver.enable then [
    gitAndTools.gitFull
  ] else [
    (gitAndTools.gitFull.override { guiSupport = false; })
    (pinentry.override { gtk2 = null; })
  ]);

  nix.trustedBinaryCaches = [ "http://hydra.nixos.org" ];
  nix.useChroot = true;

  nixpkgs.config = {
    allowUnfree = true;

    dmenu.enableXft = true;

    firefox = {
      enableAdobeFlash = true;
      enableGoogleTalkPlugin = true;
    };

    packageOverrides = super: let self = super.pkgs; in {
      haskellEnv = self.haskellngPackages.ghcWithPackages (p: with p; [
        cabal-install
        cabal2nix
        hlint
        xmobar
        xmonad
        xmonad-contrib
        xmonad-extras
      ]);
      compton-git = self.callPackage ./pkgs/compton/compton-git.nix {};
      mplus-outline-fonts = self.callPackage ./pkgs/mplus-outline-fonts {};
      weechat-minimal = self.callPackage ./pkgs/weechat/weechat-minimal.nix {};
    };
  };

  programs.emacs.enable = true;
  programs.zsh.enable = true;

  services.openssh.enable = true;

  time.timeZone = "America/New_York";

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
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
