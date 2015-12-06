{ config, lib, pkgs, ... }:

with lib;

{
  imports = import ./modules/module-list.nix;

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    boot
    ed
    emacs
    file
    gnumake
    gnupg
    htop
    jdk
    jq
    leiningen
    lsof
    maven
    mr
    ncdu
    nix-repl
    nodejs
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

  nix.useChroot = true;

  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableGoogleTalkPlugin = true;
  };

  programs.zsh.enable = true;

  services.openssh.enable = true;

  systemd.user.services.emacs = {
    description = "Emacs: The extensible, self-documenting text editor.";
    enable = true;
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.zsh}/bin/zsh -ic 'emacs --daemon'";
      ExecStop = "${pkgs.zsh}/bin/zsh -ic 'emacsclient -e \(kill-emacs\)'";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };

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
