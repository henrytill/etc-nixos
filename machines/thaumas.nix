{ config, lib, pkgs, ... }:

with lib;

let

  conkyrc = pkgs.writeText "conkyrc" ''
    out_to_console yes
    out_to_x no
    background no
    update_interval 2
    total_run_times 0
    use_spacer left
    pad_percents 3

    TEXT
    ''${addr wlp1s0}   ''${battery_percent BAT0}% (''${battery_time BAT0})   \
    ''${fs_free /}   ''$memperc% ($mem)   ''${cpu cpu1}%   ''${cpu cpu2}%   ''${acpitemp}°   \
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
      ../common.nix
      ../desktop.nix
      ../development.nix
    ];

  boot = rec {
    cleanTmpDir = true;
    kernel.sysctl = {
      "vm.laptop_mode" = 1;
    };
    kernelPackages = pkgs.linuxPackages_4_14_rt;
    kernelParams = [ "modprobe.blacklist=ehci_pci" ];
    loader.grub.device = "/dev/sda";
    loader.grub.enable = true;
  };

  environment.systemPackages = with pkgs;
    [ alsaUtils
      ncmpc
      spotify
    ];

  fileSystems."/".options = [ "defaults" "discard" "noatime" ];

  hardware.cpu.intel.updateMicrocode = true;

  ht.conky.enable = true;
  ht.conky.conkyrc = conkyrc;

  networking.hostName = "thaumas";

  powerManagement.scsiLinkPolicy = "max_performance";

  programs.ssh.setXAuthLocation = true;

  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
        type "alsa"
        name "analog out"
        device "hw:1,0"
      }
    '';
  };

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
  '';

  services.openssh.forwardX11 = true;

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

  users.extraUsers.ht.extraGroups = [ "audio" "mpd" ];
}
