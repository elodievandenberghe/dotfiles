{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    librewolfDefault.enable = lib.mkEnableOption "Sets librewolf as the default browser";
  };

  config = lib.mkIf config.librewolfDefault.enable {
      environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
  };
}
