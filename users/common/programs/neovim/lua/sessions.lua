require("auto-session").setup({
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/dev", "~/Downloads", "/"},
    pre_save_cmds = { 'Neotree close' },
    post_restore_cmds = { 'Neotree filesystem show' },
})
require("telescope").load_extension("session-lens")
