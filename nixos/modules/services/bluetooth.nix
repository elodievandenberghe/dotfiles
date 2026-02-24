{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    bluetooth.enable = lib.mkEnableOption "Enables Bluetooth and Blueman services";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    services.blueman.enable = true;
  };
}
