super: let self = super.pkgs; in {

  haskellEnv = self.haskellngPackages.ghcWithPackages (p: with p; [
    cabal-install
    cabal2nix
    hlint
    xmobar
    xmonad
    xmonad-contrib
    xmonad-extras
  ]);

}
