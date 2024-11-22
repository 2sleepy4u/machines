{
    description = "2sleepy4uu";
    inputs = {
        unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
	unstable-vim = {
		url = "github:nix-community/nixvim";
	};
	unstable-home-manager = {
		url = "github:nix-community/home-manager";
	};
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		catppuccin.url = "github:catppuccin/nix";
        nixvim = {
            url = "github:nix-community/nixvim/nixos-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    };

    outputs = { self, nixpkgs, unstable, home-manager, unstable-home-manager, nixvim, unstable-vim,  ... }@inputs: {
        nixosConfigurations = {
            sleeper = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { nixvim = nixvim; };
                modules = [
                    ./sleeper/configuration.nix
                        home-manager.nixosModules.home-manager {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = { inherit inputs; };
                            home-manager.users.im2sleepy = import ./sleeper/home.nix;
                        }
                ];
            };
            dreamer = unstable.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { nixvim = unstable-vim; };
                modules = [
                    ./dreamer/configuration.nix
                        unstable-home-manager.nixosModules.home-manager {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = { inherit inputs; };
                            home-manager.users.im2sleepy = {
								imports = [
									./dreamer/home.nix
									#catppuccin.homeManagerModules.catppuccin
								];
							};
                        }
                ];
            };
            dreamy-server = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { nixvim = inputs.nixvim; };
                modules = [
                    ./server/configuration.nix
                ];
            };
        };
    };
}
