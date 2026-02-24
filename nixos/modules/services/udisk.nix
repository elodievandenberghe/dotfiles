{
  config,
  lib,
  pkgs,
  ...
}:

{
	options = {
	  udisk.enable = lib.mkEnableOption "Enables udisk";
	};
        config = lib.mkIf config.udisk.enable {
	services.udisks2.enable = true;
	};

}
