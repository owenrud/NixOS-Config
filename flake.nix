{
  description = "NixOS configuration with Noctalia";

  nixConfig = {
  extra-substituters = [ "https://noctalia.cachix.org" ];
  extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
 };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux"; 
      specialArgs = { inherit inputs; };
      modules = [
        # ... other modules
        ./configuration.nix
	./noctalia.nix
      ];
    };
  };
}
