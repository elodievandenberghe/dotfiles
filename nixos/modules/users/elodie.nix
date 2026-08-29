{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    elodie.enable = lib.mkEnableOption "Configures the user 'elodie' and default shell";
  };

  config = lib.mkIf config.elodie.enable {
    users.users.elodie = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };

    users.defaultUserShell = pkgs.zsh;
    xdg.portal.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    users.users.vintagestory = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
	"vintagestory"
        "networkmanager"
      ];
    };

  };
}
