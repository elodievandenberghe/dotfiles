{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    flatpak.enable = lib.mkEnableOption "Enables Flatpak and XDG portal configuration";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
      config.common.default = "*";
    };
  };
}
