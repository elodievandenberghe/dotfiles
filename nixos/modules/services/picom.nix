{ config, lib, pkgs, ... }:

{
  options = {
    picom.enable = lib.mkEnableOption "Enable Picom compositor";
  };

  config = lib.mkIf config.picom.enable {
    services.picom = {
      enable = true;
      vSync = true;

      settings = {
        backend = "glx";

        corner-radius = 10;

        rounded-corners-exclude = [
          "window_type = 'dock'"
          "QTILE_INTERNAL:32c = 1"
        ];

        glx-copy-from-front = true;
        glx-swap-method = 2;
        xrender-sync = true;
        xrender-sync-fence = true;
      };
    };

    services.dbus.enable = true;
  };
}
