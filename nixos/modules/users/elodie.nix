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
