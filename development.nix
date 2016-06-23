{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    coq
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.ghc
    # haskellPackages.hasktags
    jshon
    # pandoc
  ];
}
