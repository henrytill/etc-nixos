{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cargo
    coq
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.darcs
    haskellPackages.ghc
    haskellPackages.stack
    haskellPackages.stylish-haskell
    haskellPackages.threadscope
    jshon
    rustc
    rustfmt
    rustracer
  ];
}
