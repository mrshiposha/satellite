mappings = {}
function mappings:new(info)
    if not info.description then
	error("mapping must have `description`")
    end

    local valid_modes = {
	normal = true,
	visual = true,
	insert = true,
	command = true,
	terminal = true,
    }

    local mode_capture = "#(%a+)#"

    local function map_error(msg)
	error("mapping '"..info.description.."': "..msg)
    end

    local mode_deps = {}
    local expanded_modes = {}

    local function check_and_mark_dep(mode, dep)
	if not valid_modes[dep] then
	    map_error(string.format("invalid mode dependency `%s`", dep))
	end 

	if mode == dep then
	    map_error(string.format("recursive dependency for `%s`", mode))
	end

	if mode_deps[dep] and mode_deps[dep][mode] then
	    map_error(string.format("circular dependency `%s` <-> `%s`", mode, dep))
	end

	if not mode_deps[mode] then
	    mode_deps[mode] = {}
	end

	mode_deps[mode][dep] = true
    end

    local function init_mode(mode, mapping)
	if not valid_modes[mode] then
	    map_error(string.format("invalid mode `%s`", mode))
	end	

	if type(mapping) == "string" then
	    info.modes[mode] = {}
	end
    end

    local function dep_mapping(mode, mapping)
	if type(mapping) == "string" then
	    local _, _, before, dep, after = string.find(
		mapping,
		"^(.-)"..mode_capture.."(.-)$"
	    )
	    
	    if dep then
		check_and_mark_dep(mode, dep)
	    else
		map_error("no dependency found")
	    end

	    local src_mapping, dep_transform = dep_mapping(dep, info.modes[dep])
	    src_transform = function (m)
		--print("src_transform: ", mode, mapping, m, dep_transform)
		local transformed_dep = dep_transform(m)
		return before..transformed_dep..after
	    end

	    --print(mode, mapping, src_mapping, src_transform, dep, dep_transform)
	    return src_mapping, src_transform

	elseif type(mapping) == "table" then
	    src_mapping = mapping
	    src_transform = function (mapping)
		--print("mapping: "..mapping)
		return mapping
	    end

	    --print(mode, mapping, src_mapping, src_transform)
	    return src_mapping, src_transform
	end
    end

    local function expand_mode(mode, mapping)
	if expanded_modes[mode] then
	    return info.modes[mode]
	end

	init_mode(mode, mapping)

	local src_mapping, src_transform = dep_mapping(mode, mapping)	

	for old, new in pairs(src_mapping) do
	    if type(new) == "string" then
		local expanded_mapping = string.gsub(new, mode_capture, function (dep)
		    check_and_mark_dep(mode, dep)	

		    --print(info.description, mode, old, new, info.modes[dep][old])
		    return expand_mode(dep, info.modes[dep])[old];
		end)

		--print(info.description, mode, old, expanded_mapping)

		info.modes[mode][old] = src_transform(expanded_mapping)
	    elseif type(new) == "function" then
		info.modes[mode][old] = new
	    end
	end

	expanded_modes[mode] = true
	return info.modes[mode]
    end

    for mode, mapping in pairs(info.modes) do
	expand_mode(mode, mapping)
    end

    table.insert(self, info)
    return info
end

function mappings:apply()
    for _, info in ipairs(self) do
	local options = info.options or { silent = true }
	options.desc = info.description
	
	local modes = {}
	for mode, mappings in pairs(info.modes) do
	    for old, new in pairs(mappings) do
		local short_name = mode:sub(1, 1)
		vim.keymap.set({short_name}, old, new, options)
	    end
	end
    end
end

local leave_insert = "<ESC>`^"
local enter_insert = "i"
local enter_append = "a"

function insert_reenter(mapping, enter)
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

mappings:new {
    description = "splitting windows",
    modes = {
	normal = {
	    ["<A-s>"] = "<cmd>split<cr>",
	    ["<A-v>"] = "<cmd>vsplit<cr>",
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

-- TODO
mappings:new {
    description = "toggle terminal",
    modes = {
	normal = { ["<C-`>"] = "<cmd>terminal<cr>" },
	visual = "#normal#",
	insert = "#normal#",
	-- terminal = "#normal#"
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

mappings:apply()

function keymap (modes, key, action, options)
    if options == nil then
        options = { noremap = true, silent = true }
    end
    vim.keymap.set(modes, key, action, options)
end

vim.g.VM_default_mappings = false
vim.opt.whichwrap:append("<,>,[,]")

keymap({"i"}, "<A-r>", require("telescope.builtin").registers, { noremap = true })

keymap({"n", "v"}, "<TAB>w", require("auto-session.session-lens").search_session, { noremap = true })
keymap({"n", "i", "v"}, "<A-f>", require("telescope.builtin").find_files)
keymap({"n", "i", "v"}, "<C-f>", require("telescope.builtin").live_grep)

