{
  config,
  lib,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:

{
  options = {
    commonPrograms.enable = lib.mkEnableOption "Enables common system packages configuration";
  };

  config = lib.mkIf config.commonPrograms.enable {
    environment.systemPackages =
      with pkgs;
      [
      ]
      ++ (with pkgs-stable; [
      ]);
  };
}
