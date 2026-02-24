{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    openssh.enable = lib.mkEnableOption "Enables the OpenSSH service";
  };

  config = lib.mkIf config.openssh.enable {
    services.openssh.enable = true;
  };
}
