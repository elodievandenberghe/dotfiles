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
          rev = "main";
          sha256 = "1w5w15py5rbrw1ad24din7kwcjz82mh625d7b4r7i8kzb9knl7d6";
        };

        installPhase = ''
          mkdir -p $out/share/themes
          cp -r Aether $out/share/themes/
        '';
      })
    ];

    services.xserver.displayManager.lightdm.enable = true;

    services.xserver.displayManager.lightdm.greeters.gtk = {
      enable = true;
      theme = "Aether";
    };

    services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
      theme-name=Aether
      icon-theme-name=Papirus
      font-name=Sans 10
      cursor-theme-name=Adwaita
    '';
  };
}
