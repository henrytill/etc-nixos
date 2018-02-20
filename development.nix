{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.ghc
    haskellPackages.stylish-haskell
    rtags
  ];
}
