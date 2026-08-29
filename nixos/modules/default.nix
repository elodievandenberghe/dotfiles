{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./audio/pulseaudio.nix
    ./display/de_wm/sway.nix
    ./networking/networkmanager.nix
    ./networking/hosts/laptop/firewall.nix
    ./programs/common_programs.nix
    ./services/ssh.nix
    ./services/flatpak.nix
    ./services/libinput.nix
    ./services/timezone.nix
    ./services/udisk.nix
    ./services/bluetooth.nix
    ./system/kernel.nix
    ./system/kernel_xanmod.nix
    ./system/swap.nix
    ./users/elodie.nix
    ./virtualization/qemu.nix
    ./virtualization/podman.nix
    ./modules/programs/hosts/laptop/programs.nix
  ];
  swap.enable = lib.mkDefault true; 
  pulseaudio.enable = lib.mkDefault true;
  udisk.enable = lib.mkDefault true;
  networkmanager.enable = lib.mkDefault true;
  commonPrograms.enable = lib.mkDefault true;
  openssh.enable = lib.mkDefault true;
  timezone.enable = lib.mkDefault true;
  elodie.enable = lib.mkDefault true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };
}
