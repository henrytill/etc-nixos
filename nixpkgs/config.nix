{
  allowUnfree = true;

  firefox = {
    enableAdobeFlash = true;
    enableGoogleTalkPlugin = true;
  };

  packageOverrides = import ../overrides;
}
