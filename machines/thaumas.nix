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

  linux_chromebook = pkgs.linux_latest.override {
    extraConfig = "CHROME_PLATFORMS y\n";
  };

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
    kernelPackages = pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_chromebook);
    kernelParams = [ "modprobe.blacklist=ehci_pci" ];
    loader.grub.device = "/dev/sda";
    loader.grub.enable = true;
  };

  fileSystems."/".options = [ "defaults" "discard" "noatime" ];

  hardware.cpu.intel.updateMicrocode = true;

  ht.conky.enable = true;
  ht.conky.conkyrc = conkyrc;

  networking.hostName = "thaumas";

  powerManagement.scsiLinkPolicy = "max_performance";

  programs.ssh.setXAuthLocation = true;

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
  '';

  services.openssh.forwardX11 = true;

  services.postfix.enable = true;

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

  systemd.services.drop_caches = {
    description = "drop caches";
    script = "sync; echo 3 > /proc/sys/vm/drop_caches";
    startAt = "hourly";
    serviceConfig = {
      User = "root";
    };
  };

  users.extraUsers.ht.extraGroups = [ "docker" ];

  virtualisation.docker.enable = true;
}
