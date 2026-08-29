{
  config,
  lib,
  pkgs,
  ...
}:

{

  options = {
    sway.enable = lib.mkEnableOption "Enables qtile ";
  };

  config = lib.mkIf config.qtile.enable {
   environment.systemPackages = with pkgs; [
   	wl-clipboard # Copy/Paste functionality.
        mako # Notification utility.
  ];

  # Enables Gnome Keyring to store secrets for applications. 
  services.gnome.gnome-keyring.enable = true;

  # Enable Sway.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
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
}
