{nixvim, lib, config, pkgs, ... }:
 {

	# imports = [ nixvim.nixosModules.nixvim ];

	 programs.nixvim = {
		enable = true;
		options = {
			number = true;
			tabstop = 4;
			softtabstop = 4;
			shiftwidth = 4;
			smartindent = true;
			wrap = false;
			scrolloff = 8;
			foldmethod = "syntax";
			foldenable = false;
			foldlevel = 20;
			autoread = true;
		};
		keymaps = [
		{
			key = "<Tab>";
			mode = "n";
			action = ":NERDTreeToggle<CR>";
		}
	    ];
		plugins = {
			telescope.enable = true;
			treesitter.enable = true;
			cmp-nvim-lsp.enable = true;
			cmp_luasnip.enable = true;
			luasnip.enable = true;
		};
		plugins.cmp = {
			enable = true;
			autoEnableSources = true;
			/*
			sources = [
				{name = "nvim_lsp";}
				{name = "path";}
				{name = "buffer";}
				{name = "luasnip";}
			];
			snippet = {
				expand = "function(args) require('luasnip').lsp_expand(args.body) end";
			};

			mapping = {
				"<CR>" = "cmp.mapping.confirm({ select = true })";
				"<Tab>" = {
					action = ''
						function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							else fallback()
							end
						end
					'';
					modes = [ "s" "i" ];
				};
			};
			*/
		};
		plugins.lsp = {
			enable = true;
			servers = {
				elmls.enable = true;
				nixd.enable = true;
				lua-ls.enable = true;
				rust-analyzer = {
					enable = true;
					installCargo = true;
					installRustc = true;
				};
			};
		};
		colorschemes.catppuccin.enable = true;

	 };
}
