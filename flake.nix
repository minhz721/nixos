{
  description = "NixOS configuration with Home Manager and GNOME Desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # New custom packages repository for Thorium browser
    custom-packages.url = "github:Rishabh5321/custom-packages-flake";
  };

  # FIXED: Added '@inputs' so that all input flakes can be correctly passed to configuration modules
  outputs = { nixpkgs, home-manager, custom-packages, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations.leomin = lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # Automatically backup existing conflicting files to prevent activation errors
          home-manager.backupFileExtension = "bak";

          # Pass 'inputs' so Home Manager files can access custom-packages directly for Thorium
          home-manager.extraSpecialArgs = { inherit inputs; };

          home-manager.users.leomin =
            import ./home-manager/default.nix;
        }

        # Configuration block for GNOME Desktop and Graphics Drivers
        ({ pkgs, ... }: {
          services.xserver = {
            enable = true;
            
            # Load proper open-source graphics driver for your AMD Ryzen 5 4600G
            videoDrivers = [ "amdgpu" ];

          };
        })

        # Passing inputs wrapper to make 'custom-packages' accessible inside configuration.nix
        {
          config._module.args = { inherit inputs; };
        }
      ];
    };
  };
}
