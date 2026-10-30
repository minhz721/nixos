{
  description = "NixOS configuration ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-xdm = {
      url = "github:Diomeh/nix-xdm/0.0.4";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-xdm,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
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
          home-manager.extraSpecialArgs = {inherit inputs;};

          home-manager.users.leomin = import ./home-manager/default.nix;
        }

        {
          services.xserver = {
            enable = true;
            videoDrivers = ["amdgpu"];
          };
        }
      ];
    };
  };
}
