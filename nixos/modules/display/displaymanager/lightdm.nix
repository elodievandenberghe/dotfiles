{ config, lib, pkgs, ... }:

{
  options = {
    lightdm.enable = lib.mkEnableOption "Enables lightdm";
  };

  config = lib.mkIf config.lightdm.enable {

    environment.systemPackages = with pkgs; [
      (stdenv.mkDerivation {
        name = "aether-theme";

        src = fetchFromGitHub {
          owner = "NoiSek";
          repo = "Aether";
          rev = "master";
          sha256 = "1w5w15py5rbrw1ad24din7kwcjz82mh625d7b4r7i8kzb9knl7d6";
        };

        installPhase = ''
        mkdir -p $out/share/themes/Aether
  cp -r * $out/share/themes/Aether/ 
	
	'';
      })
    ];

    services.xserver.displayManager.lightdm.enable = true;

    services.xserver.displayManager.lightdm.greeters.gtk = {
      enable = true;
      theme.name = "Aether";
    };

    services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
    [greeter]
    theme-name=Aether
    font-name=Sans 10
    cursor-theme-name=Adwaita
    '';
  };
}
