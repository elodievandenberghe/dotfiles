{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    firewall.enable = lib.mkEnableOption "Disables the firewall";
  };

  config = lib.mkIf config.firewall.enable {
    networking.firewall.enable = false;
  };
}
