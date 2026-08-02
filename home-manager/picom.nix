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
            corner-radius = 8; 
            blur = {
            method = "dual_kawase";
            strength = 5;
            };
        };
    };

}