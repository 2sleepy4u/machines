{nixvim, lib, config, pkgs, ... }:
 {
	 programs.nixvim = {
		enable = true;
		globals.mapleader = ";";
		opts = {
			number = true;
			relativenumber = true;
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
			ignorecase = true;
			conceallevel = 2;
		};
		autoCmd = [
		{
			command = "set filetype=slint";
			event = [
				"BufRead"
				"BufNewFile"
			];
			pattern = [
				"*.slint"
			];
		}
		];
		keymaps = [
		{
			key = "<C-w>N";
			mode = "n";
			action =  ":vnew<CR>";
		}
		{
			key = "<Leader>rn";
			mode = "n";
			action =  "<cmd>lua vim.lsp.buf.rename()<CR>";
		}
		{
			key = "<Leader>rf";
			mode = "n";
			action =  "<cmd>lua vim.lsp.buf.references()<CR>";
		}
		{
			key = "gd";
			mode = "n";
			action =  "<cmd>lua vim.lsp.buf.declaration()<CR>";
		}
		{
			key = "gD";
			mode = "n";
			action = "<cmd>lua vim.lsp.buf.definition()<CR>";
		}
		{
			key = "<Leader><Tab>";
			mode = "n";
			action = ":Oil<CR>";
		}
		{
			key = "<Leader>E";
			mode = "n";
			action = ":lua require('telescope.builtin').diagnostics()<CR>";
		}
		{
			key = "<Leader>s";
			mode = "n";
			action = ":lua require('telescope.builtin').lsp_document_symbols()<CR>";
		}
		{
			key = "<Leader>e";
			mode = "n";
			action = ":lua vim.diagnostic.open_float()<CR>";
		}
		{
			key = "<Leader>pf";
			mode = "n";
			action = ":Telescope find_files<CR>";
		}
		{
			key = "<leader>ps";
			mode = "n";
			action = ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<CR>";
		}
		{
			key = "<leader>pt";
			mode = "n";
			action = ":lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>";
		}
		{
			key = "<C-p>";
			mode = "n";
			action = ":Telescope git_files<CR>"; 
		}
		{
			key = "<C-space>";
			mode = "n";
			action = ":lua require('actions-preview').code_actions()<CR>";
		}
		{
			key = "<C-j>";
			mode = "n";
			action = ":DapStepOver<CR>";
		}
		{
			key = "<C-n>";
			mode = "n";
			action = ":DapContinue<CR>";
		}
		{
			key = "<C-l>";
			mode = "n";
			action = ":DapStepInto<CR>";
		}
		{
			key = "<C-.>";
			mode = "n";
			action = ":DapToggleBreakpoint<CR>";
		}
		{
			key = "<C-Tab>";
			mode = "n";
			action = ":DapToggleBreakpoint<CR>";
		}
		{
			key = "<leader>os";
			mode = "n";
			action = ":ObsidianSearch ";
		}
		{
			key = "<leader>ot";
			mode = "n";
			action = ":ObsidianTags<CR>";
		}
	    ];
		plugins = {
			oil.enable = true;
			telescope.enable = true;
			telescope.extensions.ui-select.enable = true;
			treesitter.enable = true;
			treesitter.settings.auto_install = true;
			treesitter.settings.highlight.enable = true;
			cmp-nvim-lsp.enable = true;
			undotree.enable = true;
			fugitive.enable = true;
			web-devicons.enable = true;
			#rust-tools.enable = true;
			cmp_luasnip.enable = true;
			luasnip.enable = true;
			obsidian = {
				enable = true;
				settings.workspaces = [
					{
						name = "work";
						path = "~/doc/work";
					}
				{
						name = "pers";
						path = "~/doc/pers";
					}
				];
			};
		};
		extraPlugins = with pkgs.vimPlugins; [
			edgedb-vim
			nvim-dap
			actions-preview-nvim
			hologram-nvim
			(pkgs.vimUtils.buildVimPlugin {
				 name = "marp";
				 src = pkgs.fetchFromGitHub {
				 owner = "mpas";
				 repo = "marp-nvim";
				 rev = "4f38e6ffe2f5ea260f35f7ff3e4e424b9f8bea29";
				 hash = "sha256-CebyoqIBi8xT5U+aCBwptOSz89KxhXS27kAtPrRZvT8=";
				 };
			 })
		]; 
		extraConfigLua = "
			require('hologram').setup({
				auto_display = true
			})

			require('marp').setup({
				port = 8080,
				wait_for_response_timeout = 30,
				wait_for_response_delay = 1,
			})
		";
		# ++ 
		# 	[(pkgs.vimUtils.buildVimPlugin {
		# 		name = "rust-owl";
		# 		src = pkgs.fetchFromGitHub {
		# 			owner = "cordx56";
		# 			repo = "rustowl";
		# 			tag = "v0.2.1";
		# 			# hash = "<nix NAR hash>";
		# 		};
		# 	})];



		plugins.cmp = {
			enable = true;
			autoEnableSources = true;

			settings = {
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
					"<Up>" = ''
							function(fallback)
								if cmp.visible() then
									cmp.select_prev_item()
								else fallback()
								end
							end
						'';
					"<Down>" = ''
							function(fallback)
								if cmp.visible() then
									cmp.select_next_item()
								else fallback()
								end
							end
						'';
					"<Tab>" = ''
							function(fallback)
								if cmp.visible() then
									cmp.select_next_item()
								else fallback()
								end
							end
						'';
				};
			};

		};
		plugins.lsp = {
			enable = true;
			servers = {
				ruby_lsp.enable = true;
				slint_lsp = {
					enable = true;
					cmd = ["slint-lsp"];
					filetypes = ["slint"];
				};
				qmlls.enable = true;
				ts_ls.enable = true;
				clangd = {
					enable = true;
					extraOptions = {
						cmd = [
							"clangd"
							"--background-index"
							"--clang-tidy"
						];
					};
				};
				elmls.enable = true;
				nixd.enable = true;
				lua_ls.enable = true;
				dartls.enable = true;
				pyright.enable = true;
				gopls.enable = true;
				templ.enable = true;
				# roc_ls.enable = true;
				rust_analyzer = {
					enable = true;
					installCargo = true;
					installRustc = true;
					installRustfmt = true;
				};
			};
		};
		colorschemes.catppuccin.enable = true;

	 };
}
