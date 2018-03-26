{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # haskell
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.ghc
    haskellPackages.stylish-haskell
    # rust
    rustup
    # c/c++
    rtags
  ];
}
