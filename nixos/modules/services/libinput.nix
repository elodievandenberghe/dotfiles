{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    libinput.enable = lib.mkEnableOption "Enables libinput touchpad and mouse configuration";
  };

  config = lib.mkIf config.libinput.enable {
    services.libinput.touchpad.naturalScrolling = true;
    services.libinput.mouse.accelProfile = "flat";
  };
}
