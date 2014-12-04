{ config, pkgs, ... }:

{
  boot.kernel.sysctl = { "vm.swappiness" = 10; };

  powerManagement.cpuFreqGovernor = "performance";

  services.udev = {
    # packages = [ pkgs.ffado ];
    extraRules = ''
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"
    '';
  };

  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
  ];

  environment.systemPackages = with pkgs; [
    jackaudio
  ];
}
