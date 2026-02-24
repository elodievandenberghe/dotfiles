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
  xserver.enable = true;
  qtile.enable = true;
  firewall.enable = true;
  laptopPrograms.enable = true;
  backlightOptions.enable = true;
  bluetooth.enable = true;
  flatpak.enable = true;
  libinput.enable = true;
  picom.enable = true;
  openssh.enable = true;
  timezone.enable = true;
  kernelXanmod.enable = true;
  nvidia.enable = true;
  podman.enable = true;
  qemu.enable = true;

  system.stateVersion = "24.11";

}
