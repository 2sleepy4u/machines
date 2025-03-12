{
    description = "2sleepy4uu";
    inputs = {
        nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		unstable-nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		catppuccin.url = "github:catppuccin/nix";
		nixvim = {
			url = "github:nix-community/nixvim/nixos-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		#nix-minecraft.url = "github:Infinidoge/nix-minecraft";
	};

    outputs = { 
		self, 
		catppuccin, 
		disko,
		nixpkgs, home-manager, unstable-nixpkgs,
		nixvim, nixos-wsl, ... 
	}
	@inputs: {
        nixosConfigurations = {
            waker = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { 
					nixvim = nixvim; 
				};
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
            dreamer = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { nixvim = nixvim; };
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

			# nix run nixpkgs#nixos-anywhere -- --flake .#snorer --generate-hardware-config nixos-generate-config ./snorer/hardware-configuration.nix <host>
			snorer =  nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
				specialArgs = 
				let 
					unstablePkgs = import unstable-nixpkgs { 
						system = "x86_64-linux";
						config = { allowUnfree = true; }; 
					};
				in
				{ 
					nixvim = inputs.nixvim;
					unstable = unstablePkgs;
				};
                modules = [
					disko.nixosModules.disko
					catppuccin.nixosModules.catppuccin
                    ./snorer/configuration.nix
					./snorer/hardware-configuration.nix
                ];
            };
			rem = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { nixvim = nixvim; };
				modules = [
                    ./rem/configuration.nix
                        home-manager.nixosModules.home-manager {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = { inherit inputs; };
                            home-manager.users.im2sleepy = import ./rem/home.nix;
                        }
                ];
            };
        };
    };
}
