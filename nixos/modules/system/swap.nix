{ config, lib, pkgs, ... }:

{
  options = {
    swap.enable = lib.mkEnableOption "Enable swap space";
  };

  config = lib.mkIf config.swap.enable {
swapDevices = [{
  device = "/var/lib/swapfile";
  size = 16*1024; # 16 GB
}];

  };
}
