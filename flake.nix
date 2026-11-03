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
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";
  };
  outputs = {
    nixpkgs,
    home-manager,
    noctalia-greeter,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    # Separate Unstable package set
    pkgsUnstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.leomin = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs pkgsUnstable;
      };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";

          # Pass Unstable to Home Manager
          home-manager.extraSpecialArgs = {
            inherit inputs pkgsUnstable;
          };
          home-manager.users.leomin =
            import ./home-manager/default.nix;
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
