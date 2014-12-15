pkgs:

with pkgs;

rec {
  dunst = stdenv.lib.overrideDerivation pkgs.dunst
    (oldAttrs: { patchPhase = null; });
}
