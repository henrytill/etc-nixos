{
  allowUnfree = true;

  dmenu.enableXft = true;

  firefox = {
    enableAdobeFlash = true;
    enableGoogleTalkPlugin = true;
  };

  packageOverrides = import ./overrides.nix;
}
