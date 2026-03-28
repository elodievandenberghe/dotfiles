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
    services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
  theme-name=Aether
  icon-theme-name=Papirus
  font-name=Sans 10
  cursor-theme-name=Adwaita
'';
  };
}
