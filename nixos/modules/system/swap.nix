{ config, lib, pkgs, ... }:

{
  options = {
    swap.enable = lib.mkEnableOption "Enable swap space";
  };

  config = lib.mkIf config.swap.enable {
swapDevices = [{
  device = "/var/lib/swapfile";
  size = 8*1024; # 8 GB
}];

  };
}
