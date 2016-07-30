{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cargo
    coq
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.ghc
    # haskellPackages.hasktags
    jshon
    # pandoc
    rustc
  ];
}
