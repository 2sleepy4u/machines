{
    description = "2sleepy4uu";
    inputs = {
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

    outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs: {
        nixosConfigurations = {
            sleeper = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { nixvim = inputs.nixvim; };
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
            dreamer = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { nixvim = inputs.nixvim; };
                modules = [
                    ./dreamer/configuration.nix
                        home-manager.nixosModules.home-manager {
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
