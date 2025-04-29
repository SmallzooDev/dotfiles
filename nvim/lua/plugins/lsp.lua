return {
	-- tools
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"stylua",
				"selene",
				"luacheck",
				"shellcheck",
				"shfmt",
				"gopls",
				"pyright",
				"typescript-language-server",
				"clangd",
				"clang-format",
				"cpplint",
				"cmake-language-server",
				"rust-analyzer",
			})
		end,
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			---@type lspconfig.options
			servers = {
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
							gofumpt = true,
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								diagnosticMode = "workspace",
								inlayHints = {
									variableTypes = true,
									functionReturnTypes = true,
								},
							},
						},
					},
				},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--suggest-missing-includes",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						clangdFileStatus = true,
						usePlaceholders = true,
						completeUnimported = true,
						semanticHighlighting = true,
					},
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern(
							"compile_commands.json",
							"compile_flags.txt",
							".git",
							"CMakeLists.txt"
						)(fname)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				rust_analyzer = {
					settings = {
						rust = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
				cmake = {
					cmd = { "cmake-language-server" },
					filetypes = { "cmake" },
					init_options = {
						buildDirectory = "build",
					},
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern("CMakeLists.txt", ".git")(fname)
					end,
				},
			},
			setup = {},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			vim.list_extend(keys, {
				{
					"gd",
					function()
						require("telescope.builtin").lsp_definitions({ reuse_win = false })
					end,
					desc = "Goto Definition",
					has = "definition",
				},
				{
					"g;",
					function()
						vim.lsp.buf.references()
					end,
					desc = "Jump to Last Change (IDEAVim)",
				},
				{
					"g,",
					function()
						vim.lsp.buf.implementation()
					end,
					desc = "Jump to Next Change (IDEAVim)",
				},
				{
					"[[",
					function()
						vim.lsp.buf.declaration()
					end,
					desc = "Method Up (IDEAVim)",
				},
				{
					"]]",
					function()
						vim.lsp.buf.implementation()
					end,
					desc = "Method Down (IDEAVim)",
				},
				{
					"\\p",
					function()
						vim.lsp.buf.signature_help()
					end,
					desc = "Parameter Name Hints (IDEAVim)",
				},
				{
					"<leader>ll",
					function()
						vim.lsp.buf.code_action()
					end,
					desc = "Quick List Popup Action (IDEAVim)",
				},
				{
					"<leader>rn",
					function()
						vim.lsp.buf.rename()
					end,
					desc = "Rename Element (IDEAVim)",
				},
			})
		end,
	},
}
