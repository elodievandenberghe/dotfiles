{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    backlightOptions.enable = lib.mkEnableOption "Enables backlight-related services and programs";
  };

  config = lib.mkIf config.backlightOptions.enable {
    services.upower.enable = true;

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';

  };
}
