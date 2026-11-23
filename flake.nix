{
  description = "NixOS configuration";

  inputs = {
    # Stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # Unstable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust toolchain
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
    };

    thorium = {
      url = "github:Rishabh5321/custom-packages-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # package unstable
      pkgsUnstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.leomin = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs pkgsUnstable;
        };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";

              # unstable + fenix Home Manager
              extraSpecialArgs = {
                inherit inputs pkgsUnstable;
                inherit (inputs) fenix;
              };

              users.leomin = import ./home-manager/default.nix;
            };
          }
        ];
      };
    };
}
