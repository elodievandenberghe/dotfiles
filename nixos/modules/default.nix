{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./audio/pulseaudio.nix
    ./display/xserver.nix
    ./display/de_wm/qtile.nix
    ./display/displaymanager/ligthdm.nix
    ./networking/networkmanager.nix
    ./networking/hosts/laptop/firewall.nix
    ./programs/common_programs.nix
    ./programs/hosts/laptop/programs.nix
    ./services/ssh.nix
    ./services/picom.nix
    ./services/flatpak.nix
    ./services/libinput.nix
    ./services/timezone.nix
    ./services/udisk.nix
    ./services/bluetooth.nix
    ./services/backlight_laptop.nix
    ./system/kernel.nix
    ./system/kernel_xanmod.nix
    ./system/nvidia.nix
    ./users/elodie.nix
    ./virtualization/qemu.nix
    ./virtualization/podman.nix
    ./services/wireguard.nix
    ./services/default_browser.nix
  ];
  pulseaudio.enable = lib.mkDefault true;
  wireguard.enable = lib.mkDefault true;
  udisk.enable = lib.mkDefault true;
  networkmanager.enable = lib.mkDefault true;
  commonPrograms.enable = lib.mkDefault true;
  openssh.enable = lib.mkDefault true;
  timezone.enable = lib.mkDefault true;
  librewolfDefault.enable = lib.mkDefault true; 
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
