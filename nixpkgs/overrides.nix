super: let self = super.pkgs; in {

  xmonadEnv = self.haskellngPackages.ghcWithPackages (p: with p; [
    xmobar
    xmonad
    xmonad-contrib
    xmonad-extras
  ]);

}
