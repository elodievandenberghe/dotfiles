{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}:
{
  options = {
    pulseaudio.enable = lib.mkEnableOption "Enables pulseaudio";
  };

  config = lib.mkIf config.pulseaudio.enable {
    services.pipewire.enable = false;
    services.pulseaudio.enable = true;
    services.pulseaudio.support32Bit = true;
    users.extraUsers.elodie.extraGroups = [ "audio" ];
    services.pulseaudio.extraConfig = " load-module module-switch-on-connect ";

    environment.systemPackages = with pkgs-stable; [
      pamixer
      pavucontrol
    ];
  };
}
