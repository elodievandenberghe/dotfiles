{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    lightdm.enable = lib.mkEnableOption "Enables lightdm";
  };

  config = lib.mkIf config.lightdm.enable {
    services.xserver.displayManager.lightdm.enable = true;
  };
}
