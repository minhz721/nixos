{
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
      ];

      max-jobs = "auto";
      cores = 0;

      builders-use-substitutes = true;

      keep-derivations = true;
      keep-outputs = true;
    };
  };
}