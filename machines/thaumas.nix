{ config, lib, pkgs, ... }:

with lib;

let

  conkyrc = pkgs.writeText "conkyrc" ''
    out_to_console yes
    out_to_x no
    background no
    update_interval 2
    total_run_times 0
    use_spacer none

    TEXT
    ''${addr wlp1s0}   ''${battery_percent BAT0}% (''${battery_time BAT0})   \
    ''${acpitemp}°   ''${fs_free /}   $memperc% ($mem)   \
    ''${time %a %b %d %I:%M %P}
  '';

  xmodmaprc = pkgs.writeText "xmodmaprc" ''
    remove mod4 = Super_L
    remove control = Control_L
    add mod4 = Control_L
    add control = Super_L
  '';

in {
  imports =
    [ ../hardware-configuration.nix
      ../desktop.nix
    ];

  boot =
    let
      linux_chromebook = pkgs.linux.override
        { extraConfig = "CHROME_PLATFORMS y\n"; };
    in rec {
      cleanTmpDir = true;
      kernelPackages = pkgs.recurseIntoAttrs
        (pkgs.linuxPackagesFor linux_chromebook kernelPackages);
      kernelParams = [ "modprobe.blacklist=ehci_pci" ];
      loader.grub.device = "/dev/sda";
      loader.grub.enable = true;
    };

  environment.pathsToLink = [ "/share/mozart" ];
  environment.systemPackages = with pkgs; [
    mozart-binary
  ];

  fileSystems."/".options = concatStringsSep "," [
    "defaults"
    "discard"
    "noatime"
  ];

  ht.conky.enable = true;
  ht.conky.conkyrc = conkyrc;

  networking.hostName = "thaumas";

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
  '';
  services.xserver = {
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xmodmap}/bin/xmodmap ${xmodmaprc}
    '';
    synaptics.enable = true;
    synaptics.palmDetect = true;
    synaptics.tapButtons = false;
    synaptics.twoFingerScroll = true;
  };

  sound.extraConfig = ''
    defaults.pcm.!card PCH
    defaults.pcm.!device 0
  '';
}
