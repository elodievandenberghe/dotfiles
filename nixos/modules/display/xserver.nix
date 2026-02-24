{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    xserver.enable = lib.mkEnableOption "Enables the X server";
  };

  config = lib.mkIf config.xserver.enable {
    services.xserver.enable = true;
    services.xserver.xkb.layout = "be";
  };
}
