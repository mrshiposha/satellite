require("neo-tree").setup({
    auto_clean_after_session_restore = true,
    filesystem = {
	follow_current_file = {
	    enabled = true,
	    leave_dirs_open = true,
	}
    }
})
