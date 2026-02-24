{
  config,
  lib,
  pkgs,
  ...
}:

{

  options = {
    qtile.enable = lib.mkEnableOption "Enables qtile ";
  };

  config = lib.mkIf config.qtile.enable {
    services.xserver.windowManager.qtile.enable = true;
    services.xserver.windowManager.qtile.extraPackages =
      p: with p; [
        qtile-extras
        dbus-fast
        iwlib
        pyxdg
        xdg
      ];
  };
}
