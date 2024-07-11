--local theme = {
--  fill = 'TabLineFill',
--  head = 'TabLine',
--  current_tab = 'TabLineSel',
--  tab = 'TabLine',
--  win = 'TabLine',
--  tail = 'TabLine',
--}

require("tabby.tabline").use_preset("active_wins_at_tail", {
    --buf_name = {
--	mode = "'unique'|'relative'|'tail'|'shorten'",
 --   },
    --preset = "active_tab_with_wins",
})

require("nvim-tree").setup {
    tab = {
	sync = {
	    open = true,
	    close = true,
	},
    },
    update_focused_file = {
	enable = true,
	update_root = {
	    enable = true,
	},
    },
    view = {
	preserve_window_proportions = true,
	width = {
	    min = 40,
	},
    },
    renderer = {
	indent_width = 1,
	indent_markers = {
	    enable = true,
	},
	highlight_git = "name",
	highlight_modified = "icon",
	icons = {
	    git_placement = "after",
	},
    },
    modified = {
	enable = true,
	show_on_open_dirs = false,
    },
    git = {
	enable = true,
	show_on_open_dirs = false,
    },
    trash = {
	cmd = "trash",
    },
    live_filter = {
	always_show_folders = false,
    },
    on_attach = function (buf)
	local api = require("nvim-tree.api")
	local function keymap(key, action, opts)
	    opts = opts or { buffer = buf, silent = true }
	    vim.keymap.set("n", key, action, opts)
	end

	keymap(".", function ()
	    local node = api.tree.get_node_under_cursor()

	    if node.type == "directory" then
		api.tree.change_root_to_node()
		vim.api.nvim_set_current_dir(node.absolute_path)
	    end
	end)
	keymap("<cr>", api.node.open.tab_drop)
	keymap("<2-LeftMouse>", api.node.open.tab_drop)
	keymap("<A-s>", api.node.open.horizontal)
	keymap("<A-v>", api.node.open.vertical)
	keymap("<C-Up>", api.node.navigate.sibling.prev)
	keymap("<C-Down>", api.node.navigate.sibling.next)
	keymap("<C-S-Up>", api.node.navigate.parent)
	keymap("<C-S-Down>", api.node.navigate.sibling.last)
	keymap("<C-r>", api.fs.rename)
	keymap("<C-S-r>", api.tree.reload)
	keymap("<C-c>", api.fs.copy.node)
	keymap("<C-x>", api.fs.cut)
	keymap("<C-v>", api.fs.paste)
	keymap("<C-p>", api.fs.copy.relative_path)
	keymap("<C-S-p>", api.fs.copy.absolute_path)
	keymap("<A-n>", api.fs.copy.filename)
	keymap("<C-n>", api.fs.create)
	keymap("<Del>", api.fs.trash)
	keymap("<C-f>", api.live_filter.start)
	keymap("<ESC>", api.live_filter.clear)
	keymap("<C-h>", api.tree.toggle_hidden_filter)
	keymap("<C-i>", api.tree.toggle_gitignore_filter)
	keymap("<C-a>", api.tree.expand_all)
	keymap("<C-S-a>", api.tree.collapse_all)
	keymap("?", api.tree.toggle_help)
    end,
}

vim.api.nvim_set_hl(0, "NvimTreeNormal", {
    bg = "NONE",
})

local galaxyline = {
    core = require("galaxyline"),
    section = require("galaxyline").section,
    condition = require("galaxyline.condition"),
}
vim.api.nvim_set_hl(0, "StatusLine", {
    bg = "NONE",
})

galaxyline.core.short_line_list = { "NvimTree" }

galaxyline.section.left[1] = {
    ViMode = {
	provider = function ()
	    local mode_names = {
	      ["n"] = "normal",
	      ["v"] = "visual",
	      ["V"] = "visual line",
	      [""] = "visual block", -- This is a special character for visual block mode
	      ["i"] = "insert",
	      ["R"] = "replace",
	      ["c"] = "command",
	      ["t"] = "terminal",
	      ["s"] = "select",
	      ["S"] = "select line",
	      [""] = "select block", -- This is a special character for select block mode
	    }

	    return "(- " .. (mode_names[vim.fn.mode()] or "unknown") .. " -)";
	end,
    },
}
galaxyline.section.mid[1] = {
    BranchIcon = {
	provider = function() return "  " end,
	condition = galaxyline.condition.check_git_workspace,
	separator = " ",
	separator_highlight = { nil, "NONE" },
    }
}
galaxyline.section.mid[2] = {
    GitBranch = {
	provider = 'GitBranch',
	condition = galaxyline.condition.check_git_workspace,
    }
}
galaxyline.section.right[1] = {
    PerCent = {
	provider = "LinePercent",
	separator = " ",
    }
}
galaxyline.section.right[2] = {
    FileEncode = {
	provider = "FileEncode",
	separator = " ",
    }
}
