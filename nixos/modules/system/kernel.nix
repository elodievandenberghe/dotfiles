{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    kernel.enable = lib.mkEnableOption "Enables boot configuration with latest kernel and systemd-boot";
  };

  config = lib.mkIf config.kernel.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
