{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    sound.godMode = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };

      alsaSeq.enable = mkOption {
        type = types.bool;
        default = true;
      };

      firewire.enable = mkOption {
        type = types.bool;
        default = false;
      };

    };
  };

  config = mkIf (config.sound.enable && config.sound.godMode.enable) {

    boot = {
      kernel.sysctl = { "vm.swappiness" = 10; };
      kernelModules =
        if config.sound.godMode.alsaSeq.enable then
          [ "snd-seq"
            "snd-rawmidi"
          ]
        else [ ];
      kernelParams = [ "threadirq" ];
      postBootCommands = ''
        echo 2048 > /sys/class/rtc/rtc0/max_user_freq
        echo 2048 > /proc/sys/dev/hpet/max-user-freq
      '';
    };

    powerManagement.cpuFreqGovernor = "performance";

    security.pam.loginLimits = [
      { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
      { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
      { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
      { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
    ];

    services.udev = {
      packages =
        if config.sound.godMode.firewire.enable then
          [ pkgs.ffado ]
        else [ ];

      extraRules = ''
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
      '';
    };

    users.extraGroups= { audio = { }; };

  };
}
