require("auto-session").setup({
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/dev", "~/Downloads", "/"},
})
require("telescope").load_extension("session-lens")
