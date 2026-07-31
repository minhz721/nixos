{
  description = "NixOS configuration with Home Manager and GNOME Desktop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # New custom packages repository for Thorium browser
    custom-packages.url = "github:Rishabh5321/custom-packages-flake";

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, custom-packages, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations.leomin = lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs;
      };

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

        {
          services.xserver = {
            enable = true;
            videoDrivers = [ "amdgpu" ];
          };
        }
      ];
    };
  };
}
