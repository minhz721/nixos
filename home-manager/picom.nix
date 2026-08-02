{ config, pkgs, ...}:

{
    services.picom = {
        enable = true;
        
        backend = "glx"; 
        
        vSync = true;
        fade = true;
        fadeDelta = 5;
        
        shadow = true;
        shadowOpacity = 0.75;
        
        settings = {
            # corner-radius = 12; 
            # round-borders = 1;
            blur = {
                method = "dual_kawase";
                strength = 5;
            };
        };
    };

}