{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    hypotheticaldesktopPrograms.enable = lib.mkEnableOption "Enables QEMU, virt-manager, and libvirtd configuration";
  };

  config = lib.mkIf config.hypotheticalDesktopPrograms.enable {
    environment.systemPackages = with pkgs; [
      neofetch
    ];
  };
}
