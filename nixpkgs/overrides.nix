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

  compton-git = self.callPackage ./pkgs/compton/compton-git.nix {};

  mplus-outline-fonts = self.callPackage ./pkgs/mplus-outline-fonts {};

}
