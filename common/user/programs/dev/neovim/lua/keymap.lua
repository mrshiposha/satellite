vim.g.VM_default_mappings = false
vim.opt.whichwrap:append("<,>,[,]")

local mappings = require("util").mappings

local leave_insert = "<ESC>`^"
local enter_insert = "i"
local enter_append = "a"

local function insert_reenter(mapping, enter)
    enter = enter or enter_insert
    return leave_insert..mapping..enter
end

mappings:new {
    description = "cursor and highlighting housekeeping",
    modes = {
	normal = { ["<ESC>"] = "<C-l><cmd>noh<cr>" },
	insert = { ["<ESC>"] = leave_insert },
    }
}

mappings:new {
    description = "go to the end of the line",
    modes = {
	normal = { ["-"] = "$" },
	visual = "#normal#",
    }
}

mappings:new {
    description = "go to the beginning of the line's text",
    modes = {
	normal = { ["<C-0>"] = "^" },
	visual = "#normal#",
	insert = insert_reenter("#normal#"),
    }
}

mappings:new {
    description = "go to the end of the line's text",
    modes = {
	normal = { ["<C-->"] = "g_" },
	visual = "#normal#",
	insert = insert_reenter("#normal#", enter_append),
    }
}

mappings:new {
    description = "select text until its beginning",
    modes = {
	visual = { ["<C-)>"] = "^" },
	normal = "v#visual#",
	insert = leave_insert.."#normal#",
    }
}

mappings:new {
    description = "select text until its end",
    modes = {
	visual = { ["<C-_>"] = "g_" },
	normal = "v#visual#",
	insert = leave_insert.."#normal#",
    }
}

mappings:new {
    description = "select words",
    modes = {
	visual = {
	    ["<C-S-Left>"] = "b",
	    ["<C-S-Right>"] = "e",
	    ["<C-S-e>"] = "E",
	    ["<C-S-b>"] = "B",
	    ["<S-i>"] = "iw",
	    ["<C-S-i>"] = "iW",
	},
	normal = "v#visual#",
	insert = {
	    ["<C-S-Left>"] = "<ESC>#normal#",
	    ["<C-S-Right>"] = leave_insert.."#normal#",
	},
    }
}

mappings:new {
    description = "select lines",
    modes = {
	normal = {
	    ["<S-Up>"] = "<S-v><Up>",
	    ["<S-Down>"] = "<S-v><Down>",
	    ["<S-Right>"] = "<S-v>",
	},
	visual = {
	    ["<S-Up>"] = "<Up>",
	    ["<S-Down>"] = "<Down>",
	    ["<S-Left>"] = "<Left>",
	    ["<S-Right>"] = "<S-v>",
	},
	insert = leave_insert.."#normal#",
    }
}

mappings:new {
    description = "select all",
    modes = {
	normal = { ["<C-a>"] = "ggVG" },
	visual = "<ESC>#normal#",
    }
}

mappings:new {
    description = "save the file",
    modes = {
	normal = { ["<C-s>"] = "<cmd>w<cr>" },
	visual = "#normal#",
	insert = leave_insert.."#normal#",
    }
}

local terminal_enter_normal = "<C-\\><C-n>"
mappings:new {
    description = "enter normal mode in terminal",
    modes = {
	terminal = { ["<ESC>"] = terminal_enter_normal }
    }
}

mappings:new {
    description = "copy & paste",
    modes = {
	visual = { ["<C-c>"] = "\"+y" },
	normal = {
	    ["<C-c>"] = "\"+yy",
	    ["<C-v>"] = "\"+gP",
	},
	insert = {
	    ["<C-c>"] = leave_insert.."#normal#",
	    ["<C-v>"] = "<C-R>+",
	},
	terminal = {
	    ["<C-S-v>"] = terminal_enter_normal.."\"+gPi"
	},
    }
}

mappings:new {
    description = "command paste",
    modes = {
	command = { ["<C-v>"] = "<C-r>+" }
    },
    options = {
	silent = false
    },
}

mappings:new {
    description = "cut",
    modes = {
	visual = { ["<C-x>"] = "\"+d" },
	normal = { ["<C-x>"] = "\"+dd" },
	insert = leave_insert.."#normal#",
    }
}

mappings:new {
    description = "undo",
    modes = {
	normal = { ["<C-z>"] = "u" },
	visual = "#normal#",
	insert = leave_insert.."#normal#",
    }
}

mappings:new {
    description = "redo",
    modes = {
	normal = { ["<C-S-z>"] = "<C-r>" },
	visual = "<ESC>#normal#",
	insert = leave_insert.."#normal#",
    }
}

local scroll_speed = 5;
local scroll_up = scroll_speed.."<C-y>"
local scroll_down = scroll_speed.."<C-e>"
mappings:new {
    description = "scrolling",
    modes = {
	normal = {
	    ["<ScrollWheelUp>"] = scroll_up,
	    ["<C-Up>"] = scroll_up,

	    ["<ScrollWheelDown>"] = scroll_down,
	    ["<C-Down>"] = scroll_down,
	},
	visual = "#normal#",
	insert = leave_insert.."#normal#",
    }
}

mappings:new {
    description = "panel change",
    modes = {
	normal = {
	    ["<Tab><Left>"] = "<C-w><Left>",
	    ["<Tab><Right>"] = "<C-w><Right>",
	    ["<Tab><Up>"] = "<C-w><Up>",
	    ["<Tab><Down>"] = "<C-w><Down>",
	},
	visual = "#normal#",
    }
}

mappings:new {
    description = "text navigation",
    modes = {
	normal = {
	    ["<C-Left>"] = "b",
	    ["<C-Right>"] = "e",
	},
	visual = "#normal#",
	insert = {
	    ["<C-Left>"] = insert_reenter("#normal#"),
	    ["<C-Right>"] = insert_reenter("#normal#", enter_append),
	},
    }
}

mappings:new {
    description = "moving lines",
    modes = {
	normal = {
	    ["<A-Left>"] = "<<",
	    ["<A-Right>"] = ">>",
	    ["<A-Up>"] = "<cmd>m .-2<cr>",
	    ["<A-Down>"] = "<cmd>m .+1<cr>",
	},
	insert = insert_reenter("#normal#"),
	visual = {
	    ["<A-Left>"] = "<gv",
	    ["<A-Right>"] = ">gv",
	    ["<A-Up>"] = ":m '<-2<cr>gv=gv",
	    ["<A-Down>"] = ":m '>+1<cr>gv=gv",
	},
    }
}

local function split_window(direction)
    direction = direction == "h" and "" or direction
    local split_cmd = direction.."split"

    if vim.bo.buftype == "terminal" then
	vim.api.nvim_command("startinsert | "..split_cmd.." | terminal")
    else
	vim.api.nvim_command(split_cmd)
    end
end
mappings:new {
    description = "splitting windows",
    modes = {
	normal = {
	    ["<A-s>"] = function () split_window("h") end,
	    ["<A-v>"] = function () split_window("v") end,
	},
	visual = "#normal#",
	insert = "#normal#",
	terminal = "#normal#",
    },
}

local resize_h_speed = 1
local resize_v_speed = 5
mappings:new {
    description = "resizing windows",
    modes = {
	normal = {
	    ["<C-A-->"] = "<cmd>vertical resize -"..resize_v_speed.."<cr>",
	    ["<C-A-=>"] = "<cmd>vertical resize +"..resize_v_speed.."<cr>",
	    ["<C-A-_>"] = "<cmd>resize -"..resize_h_speed.."<cr>",
	    ["<C-A-+>"] = "<cmd>resize +"..resize_h_speed.."<cr>",
	},
    },
}

mappings:new {
    description = "swapping windows",
    modes = {
	normal = { ["<A-x>"] = "<C-w>x" },
	visual = "#normal#",
	insert = "#normal#",
	terminal = "#normal#",
    },
}

mappings:new {
    description = "delete words",
    modes = {
	command = { ["<C-BS>"] = "<C-W>" },
	insert = "#command#",
    },
    options = {
	silent = false,
    }
}

local function find_terminal()
    local wins = require("util").list_tab_wins()
    local terminal_win = nil

    for _, win in ipairs(wins) do
	if vim.api.nvim_buf_get_option(win.buf, "buftype") == "terminal" then
	    terminal_win = win.id
	    break
	end
    end

    return terminal_win
end
mappings:new {
    description = "toggle terminal",
    modes = {
	normal = {
	    ["<C-`>"] = function ()
		local terminal = find_terminal()
		if terminal then
		    if vim.bo.buftype ~= "terminal" then
			vim.api.nvim_set_current_win(terminal)
		    end
		else
		    vim.api.nvim_command("vsplit | terminal")
		end
	    end
	},
	visual = "#normal#",
	insert = "#normal#",
    }
}

mappings:new {
    description = "tab navigation",
    modes = {
	normal = {
	    ["<C-Tab>"] = "<cmd>tabn<cr>",
	    ["<C-S-Tab>"] = "<cmd>tabp<cr>",
	    ["<C-S-Up>"] = "",
	    ["<C-S-Down>"] = "",
--	    ["<C-w>"] = function ()
    --	    	TODO closing panels & tabs
--		print("works!")
--	    end,
	},
	visual = "#normal#",
	insert = "#normal#",
    }
}

mappings:new {
    description = "Toggle file tree",
    modes = {
	normal = {
	    ["<C-b>"] = "<cmd>NvimTreeToggle<cr>",
	},
    },
}

mappings:new {
    description = "List sessions",
    modes = {
	normal = {
	    ["<Tab>s"] = require("auto-session.session-lens").search_session
	},
	visual = "#normal#",
    },
    options = {
	silent = false,
    },
}

mappings:new {
    description = "Find Utilities",
    modes = {
	normal = {
	    ["<A-f>"] = require("telescope.builtin").find_files,
	    ["<C-S-f>"] = require("telescope.builtin").live_grep,
	},
	visual = "#normal#",
	insert = "#normal#",
    },
}

mappings:new {
    description = "Show registers",
    modes = {
	normal = {
	    ["<A-r>"] = require("telescope.builtin").registers,
	},
	visual = "#normal#",
	insert = "#normal#",
    },
}

mappings:apply()

