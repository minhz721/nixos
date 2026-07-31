{ pkgs, config, inputs, ... }: {

  # Import Noctalia's Home Manager module
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # Main configuration for the Noctalia desktop shell
  programs.noctalia-shell = {
    enable = true;
    
    # Enable systemd user service for automatic startup
    systemd.enable = true;

    # Desktop shell settings, wallpapers, and security
    settings = {
      bar = {
        density = "compact";
      };

      # Desktop background settings
      wallpaper = {
        enabled = true;
        
        # Dynamically fetch the current user's home directory
        directory = "${config.home.homeDirectory}/Pictures";
        
        # Display modes: "crop" | "center" | "fit" | "stretch"
        fill_mode = "crop";
        
        # Wallpaper transition animations
        transition = [ "fade" "wipe" "zoom" ];
        transition_duration = 1500;
      };

      # Lock screen and idle configuration
      lockscreen = {
        enabled = true;
        
        # Lock screen timeout in seconds
        idle_timeout = 600; 
        
        # Background blur strength
        blur_radius = 20;
        
        # Enable biometric unlocking alongside PAM passwords
        biometric_auth = true; 
      };
    };
  };
}
