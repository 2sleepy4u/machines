{
    description = "2sleepy4uu";
    inputs = {
        nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
		#unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		#unstable-vim.url = "github:nix-community/nixvim";
		#unstable-home-manager.url = "github:nix-community/home-manager";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		catppuccin.url = "github:catppuccin/nix";
		nixvim = {
			url = "github:nix-community/nixvim/nixos-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		#nix-minecraft.url = "github:Infinidoge/nix-minecraft";
	};

    outputs = { self, catppuccin, nixpkgs, home-manager, nixvim, nixos-wsl, ... }@inputs: {
        nixosConfigurations = {
            waker = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { nixvim = nixvim; };
                modules = [
                    nixos-wsl.nixosModules.default
                    {
                        system.stateVersion = "24.05";
						wsl.defaultUser = "im2sleepy";
                        wsl.enable = true;
                    }
					catppuccin.nixosModules.catppuccin
                    ./waker/configuration.nix
                ];
            };
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
            #dreamer = unstable.lib.nixosSystem {
            dreamer = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { nixvim = nixvim; };
                #specialArgs = { nixvim = unstable-vim; };
                modules = [
                    ./dreamer/configuration.nix
                        #unstable-home-manager.nixosModules.home-manager {
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
