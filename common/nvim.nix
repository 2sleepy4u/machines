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
			key = "<Leader>r";
			mode = "n";
			action =  "<cmd>lua vim.lsp.buf.rename()<CR>";
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
			key = "<Tab>";
			mode = "n";
			action = ":Lexplore<CR>";
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
	    ];
		plugins = {
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
		};
		extraPlugins = with pkgs.vimPlugins; [
			edgedb-vim
			nvim-dap
			actions-preview-nvim
		];


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
				slint_lsp = {
					enable = true;
					cmd = ["slint-lsp"];
					filetypes = ["slint"];
				};
				qmlls.enable = true;
				ts_ls.enable = true;
				clangd.enable = true;
				elmls.enable = true;
				nixd.enable = true;
				lua_ls.enable = true;
				dartls.enable = true;
				pyright.enable = true;
				gopls.enable = true;
				templ.enable = true;
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
