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

    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
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

              extraSpecialArgs = {
                inherit inputs pkgsUnstable;
              };

              users.leomin = import ./home-manager/default.nix;
            };
          }
        ];
      };
    };
}
