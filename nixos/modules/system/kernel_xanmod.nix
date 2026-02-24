{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    kernelXanmod.enable = lib.mkEnableOption "Enables boot configuration with the latest Xanmod kernel and systemd-boot";
  };

  config = lib.mkIf config.kernelXanmod.enable {
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
