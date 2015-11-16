{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.ht.conky;

  conkyrc-default = pkgs.writeText "conkyrc-default" ''
    out_to_console yes
    out_to_x no
    background no
    update_interval 10
    total_run_times 0
    use_spacer none

    TEXT
    ''${fs_free /}    $memperc% ($mem)    ''${time %a %b %d %I:%M %P}
  '';

in {
  options.ht.conky = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable conky module
      '';
    };
    conkyrc = mkOption {
      default = conkyrc-default;
      description = ''
        Derivation for conkyrc
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.conky = {
      description = "conky";
      enable = true;
      environment.DISPLAY = ":0";
      script = ''
        c_cmd="${pkgs.conky}/bin/conky"
        x_cmd="${pkgs.xorg.xsetroot}/bin/xsetroot"

        $c_cmd -c "${cfg.conkyrc}" \
            | while read LINE; do $x_cmd -name "$LINE"; done &
      '';
      serviceConfig = {
        Type = "forking";
      };
      wantedBy = [ "default.target" ];
    };
  };
}
