{
  config,
  lib,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./hardware-configuration.nix
    ../../modules/default.nix
  ];
  sway.enable = true;
  firewall.enable = true;
  laptopPrograms.enable = true;
  bluetooth.enable = true;
  flatpak.enable = true;
  libinput.enable = true;
  openssh.enable = true;
  timezone.enable = true;
  kernel.enable = true;
  podman.enable = true;
  qemu.enable = true;

  system.stateVersion = "24.11";

}
