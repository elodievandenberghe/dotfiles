{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    qemu.enable = lib.mkEnableOption "Enables QEMU, virt-manager, and libvirtd configuration";
  };

  config = lib.mkIf config.qemu.enable {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ "elodie" ];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

    environment.systemPackages = with pkgs; [
      qemu
    ];
  };
}
