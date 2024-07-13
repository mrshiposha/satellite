local plugins = {
    cmp = require("cmp"),
    lspcfg = require("lspconfig"),
    nvimlsp = require("cmp_nvim_lsp"),
    luasnip = require("luasnip"),
    autopairs = require("nvim-autopairs"),
    cmp_autopairs = require("nvim-autopairs.completion.cmp"),
};

local cmp_mapping = plugins.cmp.mapping
local cmp_modes = {"i", "c"}

plugins.cmp.setup {
    completion = {
	completeopt = "menu,menuone,preview",
    },
    mapping = {
	["<C-Space>"] = cmp_mapping.complete(),
	["<Tab>"] = cmp_mapping(cmp_mapping.confirm { select = true }, cmp_modes),
	["<CR>"] = cmp_mapping(cmp_mapping.confirm { select = true }, cmp_modes),
	["<Down>"] = cmp_mapping(cmp_mapping.select_next_item(), cmp_modes),
	["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item(), cmp_modes),
	["<C-A-Down>"] = cmp_mapping(cmp_mapping.scroll_docs(4), cmp_modes),
	["<C-A-UP>"] = cmp_mapping(cmp_mapping.scroll_docs(-4), cmp_modes),
    },
    sources = plugins.cmp.config.sources {
	{ name = "nvim_lsp" },
	{ name = "buffer" },
    },
    snippet = {
	expand = function(args)
	    plugins.luasnip.lsp_expand(args.body)
	end,
    },
}
plugins.cmp.setup.cmdline({"/", "?"}, {
    sources = {
	{ name = "buffer" },
    },
})
plugins.cmp.setup.cmdline(":", {
    sources = {
	{ name = "cmdline" },
	{ name = "path" },
	{
	    name = "cmdline",
	    option = { ignore_cmds = {"!"} }
	},
    },
    matching = { disallow_symbol_nonprefix_matching = false },
})

plugins.lspcfg["lua_ls"].setup {
    capabilities = plugins.nvimlsp.default_capabilities(),
}
plugins.lspcfg["nil_ls"].setup {
    capabilities = plugins.nvimlsp.default_capabilities(),
}

plugins.autopairs.setup {}
plugins.cmp.event:on(
    "confirm_done",
    plugins.cmp_autopairs.on_confirm_done()
)

