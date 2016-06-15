{ config, lib, pkgs, ... }:

with lib;

{
  environment.systemPackages = with pkgs; [
    activator
    boot
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.ghc
    # haskellPackages.hasktags
    jdk
    jshon
    leiningen
    maven
    nodejs
    # pandoc
    phantomjs2
    sbt
  ];

  environment.variables.JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
}
