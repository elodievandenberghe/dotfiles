{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    networkmanager.enable = lib.mkEnableOption "Enables NetworkManager";
  };

  config = lib.mkIf config.networkmanager.enable {
    networking.networkmanager.enable = true;
  };
}
