{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    timezone.enable = lib.mkEnableOption "Enables time zone configuration";
  };

  config = lib.mkIf config.timezone.enable {
    time.timeZone = "Europe/Brussels";
  };
}
