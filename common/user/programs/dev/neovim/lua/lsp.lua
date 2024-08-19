local plugins = {
	cmp = require("cmp"),
	lspcfg = require("lspconfig"),
	nvimlsp = require("cmp_nvim_lsp"),
	luasnip = require("luasnip"),
	trouble = require("trouble"),
	autopairs = require("nvim-autopairs"),
	cmp_autopairs = require("nvim-autopairs.completion.cmp"),
	preview = require("actions-preview"),
	preview_hl = require("actions-preview.highlight").delta
};

local cmp_mapping = plugins.cmp.mapping
local cmp_modes = {"i", "c"}

local function default_cmp_sources()
	return {
		{
			name = "nvim_lsp",
			entity_filter = function ()
				return #vim.lsp.get_active_clients() > 0
			end
		},
		{name = "buffer"},
		{name = "luasnip"},
	}
end
plugins.cmp.setup {
	completion = {completeopt = "menu,menuone,preview"},
	mapping = {
		["<C-Space>"] = cmp_mapping.complete(),
		["<Tab>"] = cmp_mapping(cmp_mapping.confirm {select = true}, cmp_modes),
		["<CR>"] = cmp_mapping(cmp_mapping.confirm {select = true}, {"i"}),
		["<Down>"] = cmp_mapping(cmp_mapping.select_next_item(), cmp_modes),
		["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item(), cmp_modes),
		["<C-A-Down>"] = cmp_mapping(cmp_mapping.scroll_docs(4), cmp_modes),
		["<C-A-UP>"] = cmp_mapping(cmp_mapping.scroll_docs(-4), cmp_modes)
	},
	sources = plugins.cmp.config.sources(default_cmp_sources()),
	snippet = {expand = function(args) plugins.luasnip.lsp_expand(args.body) end}
}
plugins.luasnip.setup {
	update_events = {"TextChanged", "TextChangedI"},
}
plugins.cmp.setup.cmdline({"/", "?"}, {sources = {{name = "buffer"}}})
plugins.cmp.setup.cmdline(":", {
	sources = {
		{name = "cmdline"}, {name = "path"},
		{name = "cmdline", option = {ignore_cmds = {"!"}}}
	},
	matching = {disallow_symbol_nonprefix_matching = false}
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local sources = default_cmp_sources()
		local type = vim.bo.filetype

		if type == "nix" then
			table.insert(sources, {name = "path"})

			plugins.cmp.setup.buffer {sources = sources}
		end
	end
})

vim.g.rustaceanvim = {
	server = {
		auto_attach = true,
		cmd = function ()
			return { "direnv", "exec", vim.fn.getcwd(), "rust-analyzer", "--log-file", vim.fn.tempname() .. '-rust-analyzer.log' }
		end,
	},
}

plugins.lspcfg["lua_ls"].setup {
	capabilities = plugins.nvimlsp.default_capabilities(),
	settings = {Lua = {diagnostics = {globals = {"vim"}}}},
}
plugins.lspcfg["nil_ls"].setup {
	capabilities = plugins.nvimlsp.default_capabilities(),
}
plugins.lspcfg["tsserver"].setup {
	capabilities = plugins.nvimlsp.default_capabilities(),
}
plugins.lspcfg["texlab"].setup {
	capabilities = plugins.nvimlsp.default_capabilities(),
}

plugins.trouble.setup {}

plugins.autopairs.setup {}
plugins.cmp.event:on("confirm_done", plugins.cmp_autopairs.on_confirm_done())

plugins.preview.setup {
	highlight_command = { plugins.preview_hl("delta -s -n") },
	telescope = {
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			width = 0.8,
			height = 0.9,
			prompt_position = "top",
			preview_cutoff = 20,
			preview_height = function(_, _, max_lines)
				return max_lines - 15
			end,
		},
	},
}
