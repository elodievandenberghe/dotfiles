{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    podman.enable = lib.mkEnableOption "Enables Podman, libvirt, containers, and related packages";
  };

  config = lib.mkIf config.podman.enable {
    virtualisation = {
      containers.enable = true;

      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    environment.systemPackages = with pkgs; [
      docker-compose
      podman-tui
      dive
      distrobox
    ];
  };
}
