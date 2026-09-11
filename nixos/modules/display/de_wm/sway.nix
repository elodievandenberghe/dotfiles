{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.sway.enable = lib.mkEnableOption "Enable Sway";

  config = lib.mkIf config.sway.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      mako
    ];

    # Enables Gnome Keyring to store secrets for applications.
    services.gnome.gnome-keyring.enable = true;
    programs.waybar.enable = true;
    # Enable Sway.
    programs.sway = {
      enable = true;
      package = pkgs.swayfx; 
      wrapperFeatures.gtk = true;
    };
xdg.portal = {
  enable = true;
  wlr.enable = true;
  extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
};

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };
  };
}

