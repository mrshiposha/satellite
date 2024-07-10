vim.opt.sessionoptions = "tabpages,curdir,options,globals,localoptions"

require("auto-session").setup({
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/dev", "~/Downloads", "/"},
    auto_restore_lazy_delay_enabled = false,
    post_restore_cmds = { "NvimTreeOpen" },
})

require("telescope").load_extension("session-lens")
