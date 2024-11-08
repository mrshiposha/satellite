local util = require("util")
local telescope = {
	actions = require("telescope.actions"),
	action_state = require("telescope.actions.state"),
	builtin = require("telescope.builtin"),
	pickers = require("telescope.pickers"),
	finders = require("telescope.finders"),
	sorters = require("telescope.sorters"),
	previewers = require("telescope.previewers"),
}

vim.g.VM_default_mappings = false
vim.opt.whichwrap:append("<,>,[,]")

local mappings = util.mappings

local leave_insert = "<ESC>`^"
local enter_insert = "i"
local enter_append = "a"

local function insert_reenter(mapping, enter)
	enter = enter or enter_insert
	return leave_insert .. mapping .. enter
end

mappings:new{
	description = "cursor and highlighting housekeeping",
	modes = {
		normal = {["<ESC>"] = "<C-l><cmd>noh<cr>"},
		insert = {["<ESC>"] = leave_insert}
	}
}

mappings:new{
	description = "go to the end of the line",
	modes = {normal = {["-"] = "$"}, visual = "#normal#"}
}

mappings:new{
	description = "go to the beginning of the line's text",
	modes = {
		normal = {["<C-0>"] = "^"},
		visual = "#normal#",
		insert = insert_reenter("#normal#")
	}
}

mappings:new{
	description = "go to the end of the line's text",
	modes = {
		normal = {["<C-->"] = "g_"},
		visual = "#normal#",
		insert = insert_reenter("#normal#", enter_append)
	}
}

mappings:new{
	description = "select text until its beginning",
	modes = {
		visual = {["<C-)>"] = "^"},
		normal = "v#visual#",
		insert = leave_insert .. "#normal#"
	}
}

mappings:new{
	description = "select text until its end",
	modes = {
		visual = {["<C-_>"] = "g_"},
		normal = "v#visual#",
		insert = leave_insert .. "#normal#"
	}
}

mappings:new{
	description = "select words",
	modes = {
		visual = {
			["<C-S-Left>"] = "b",
			["<C-S-Right>"] = "e",
			["<C-S-e>"] = "E",
			["<C-S-b>"] = "B",
			["<S-i>"] = "iw",
			["<C-S-i>"] = "iW"
		},
		normal = "v#visual#",
		insert = {
			["<C-S-Left>"] = "<ESC>#normal#",
			["<C-S-Right>"] = leave_insert .. "#normal#"
		}
	}
}

mappings:new{
	description = "select lines",
	modes = {
		normal = {
			["<S-Up>"] = "<S-v><Up>",
			["<S-Down>"] = "<S-v><Down>",
			["<S-Right>"] = "<S-v>"
		},
		visual = {
			["<S-Up>"] = "<Up>",
			["<S-Down>"] = "<Down>",
			["<S-Left>"] = "<Left>",
			["<S-Right>"] = "<S-v>"
		},
		insert = leave_insert .. "#normal#"
	}
}

mappings:new{
	description = "select all",
	modes = {normal = {["<C-a>"] = "ggVG"}, visual = "<ESC>#normal#"}
}

mappings:new{
	description = "save the file",
	modes = {
		normal = {["<C-s>"] = "<cmd>w<cr>"},
		visual = "#normal#",
		insert = leave_insert .. "#normal#"
	}
}

local terminal_enter_normal = "<C-\\><C-n>"
mappings:new{
	description = "enter normal mode in terminal",
	modes = {terminal = {["<ESC>"] = terminal_enter_normal}}
}

mappings:new{
	description = "copy & paste",
	modes = {
		visual = {["<C-c>"] = "\"+y"},
		normal = {["<C-c>"] = "\"+yy", ["<C-v>"] = "\"+gP"},
		insert = {["<C-c>"] = leave_insert .. "#normal#", ["<C-v>"] = "<C-R>+"},
		terminal = {["<C-S-v>"] = terminal_enter_normal .. "\"+gPi"}
	}
}

mappings:new{
	description = "command paste",
	modes = {command = {["<C-v>"] = "<C-r>+"}},
	options = {silent = false}
}

mappings:new{
	description = "cut",
	modes = {
		visual = {["<C-x>"] = "\"+d"},
		normal = {["<C-x>"] = "\"+dd"},
		insert = leave_insert .. "#normal#"
	}
}

mappings:new{
	description = "undo",
	modes = {
		normal = {["<C-z>"] = "u"},
		visual = "#normal#",
		insert = leave_insert .. "#normal#"
	}
}

mappings:new{
	description = "redo",
	modes = {
		normal = {["<C-S-z>"] = "<C-r>"},
		visual = "<ESC>#normal#",
		insert = leave_insert .. "#normal#"
	}
}

local scroll_speed = 5;
local scroll_up = scroll_speed .. "<C-y>"
local scroll_down = scroll_speed .. "<C-e>"
mappings:new{
	description = "scrolling",
	modes = {
		normal = {
			["<ScrollWheelUp>"] = scroll_up,
			["<C-Up>"] = scroll_up,

			["<ScrollWheelDown>"] = scroll_down,
			["<C-Down>"] = scroll_down
		},
		visual = "#normal#",
		insert = leave_insert .. "#normal#"
	}
}

mappings:new{
	description = "panel change",
	modes = {
		normal = {
			["<Tab><Left>"] = "<C-w><Left>",
			["<Tab><Right>"] = "<C-w><Right>",
			["<Tab><Up>"] = "<C-w><Up>",
			["<Tab><Down>"] = "<C-w><Down>"
		},
		visual = "#normal#"
	}
}

mappings:new{
	description = "text navigation",
	modes = {
		normal = {["<C-Left>"] = "b", ["<C-Right>"] = "e"},
		visual = "#normal#",
		insert = {
			["<C-Left>"] = insert_reenter("#normal#"),
			["<C-Right>"] = insert_reenter("#normal#", enter_append)
		}
	}
}

mappings:new{
	description = "moving lines",
	modes = {
		normal = {
			["<A-Left>"] = "<<",
			["<A-Right>"] = ">>",
			["<A-Up>"] = "<cmd>m .-2<cr>",
			["<A-Down>"] = "<cmd>m .+1<cr>"
		},
		insert = insert_reenter("#normal#"),
		visual = {
			["<A-Left>"] = "<gv",
			["<A-Right>"] = ">gv",
			["<A-Up>"] = ":m '<-2<cr>gv=gv",
			["<A-Down>"] = ":m '>+1<cr>gv=gv"
		}
	}
}

local function split_window(direction)
	direction = direction == "h" and "" or direction
	local split_cmd = direction .. "split"

	if vim.bo.buftype == "terminal" then
		vim.api.nvim_command("startinsert | " .. split_cmd .. " | terminal")
	else
		vim.api.nvim_command(split_cmd)
	end
end
mappings:new{
	description = "splitting windows",
	modes = {
		normal = {
			["<A-s>"] = function() split_window("h") end,
			["<A-v>"] = function() split_window("v") end
		},
		visual = "#normal#",
		insert = "#normal#",
		terminal = "#normal#"
	}
}

local resize_h_speed = 1
local resize_v_speed = 5
mappings:new{
	description = "resizing windows",
	modes = {
		normal = {
			["<C-A-->"] = "<cmd>vertical resize -" .. resize_v_speed .. "<cr>",
			["<C-A-=>"] = "<cmd>vertical resize +" .. resize_v_speed .. "<cr>",
			["<C-A-_>"] = "<cmd>resize -" .. resize_h_speed .. "<cr>",
			["<C-A-+>"] = "<cmd>resize +" .. resize_h_speed .. "<cr>"
		}
	}
}

mappings:new{
	description = "swapping windows",
	modes = {
		normal = {["<A-x>"] = "<C-w>x"},
		visual = "#normal#",
		insert = "#normal#",
		terminal = "#normal#"
	}
}

mappings:new{
	description = "delete words",
	modes = {command = {["<C-BS>"] = "<C-W>"}, insert = "#command#"},
	options = {silent = false}
}

local function find_terminal()
	local wins = util.list_tab_wins()
	local terminal_win = nil

	for _, win in ipairs(wins) do
		if vim.api.nvim_buf_get_option(win.buf, "buftype") == "terminal" then
			terminal_win = win.id
			break
		end
	end

	return terminal_win
end
mappings:new{
	description = "toggle terminal",
	modes = {
		normal = {
			["<C-`>"] = function()
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
		insert = "#normal#"
	}
}

mappings:new{
	description = "tab navigation",
	modes = {
		normal = {
			["<C-Tab>"] = "<cmd>tabn<cr>",
			["<C-S-Tab>"] = "<cmd>tabp<cr>",
			["<C-S-Up>"] = "",
			["<C-S-Down>"] = "",
			["<C-w>"] = function()
				local wins = util.list_tab_wins()
				local filewins = 0
				for _, win in ipairs(wins) do
					if vim.bo[win.buf].buftype == "" then filewins = filewins + 1 end
				end

				local current_buf = vim.api.nvim_get_current_buf()
				local current_is_file = vim.bo[current_buf].buftype == ""

				if current_is_file and filewins == 1 then
					vim.api.nvim_command("tabclose")
				else
					vim.api.nvim_command("quit")
				end
			end
		},
		visual = "#normal#",
		insert = "#normal#",
		terminal = "#normal#"
	}
}

mappings:new{
	description = "Toggle file tree",
	modes = {normal = {["<C-b>"] = "<cmd>NvimTreeToggle<cr>"}}
}

mappings:new{
	description = "List sessions",
	modes = {
		normal = {["<Tab>s"] = require("auto-session.session-lens").search_session},
		visual = "#normal#"
	},
	options = {silent = false}
}

mappings:new{
	description = "Find Utilities",
	modes = {
		normal = {
			["<A-f>"] = require("telescope.builtin").find_files,
			["<C-S-f>"] = require("telescope.builtin").live_grep
		},
		visual = "#normal#",
		insert = "#normal#"
	}
}

mappings:new{
	description = "Show registers",
	modes = {
		normal = {["<A-r>"] = require("telescope.builtin").registers},
		visual = "#normal#",
		insert = "#normal#"
	}
}

local commenter = require("nvim_comment")
commenter.setup {create_mappings = false}
mappings:new{
	description = "Comments",
	modes = {
		normal = {["<C-/>"] = "<cmd>set operatorfunc=CommentOperator<cr>g@l"},
		visual = {["<C-/>"] = ":<C-u>call CommentOperator(visualmode())<cr>"}
	}
}

mappings:new{
	description = "Show LazyGit",
	modes = {
		normal = {["<C-g>"] = "<cmd>LazyGit<cr>"},
		visual = "#normal#",
		insert = "#normal#",
		terminal = "#normal#"
	}
}

local function lsp_actions()
	telescope.pickers.new({}, {
		prompt_title = "LSP Actions",
		finder = telescope.finders.new_table {
			results = {
				{ "Actions", require("actions-preview").code_actions },
				{ "Definitions", vim.lsp.buf.definition },
				{ "References", vim.lsp.buf.references },
			},
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry[1],
					ordinal = entry[1],
				}
			end,
		},
		sorter = telescope.sorters.get_generic_fuzzy_sorter(),
		previewer = telescope.previewers.new_buffer_previewer({
			define_preview = function (_, entry)
				vim.schedule(function ()
					if entry.preview_command then
						vim.lsp.buf.definition()
					end
				end)
			end
		}),
		attach_mappings = function(prompt_bufnr)
			telescope.actions.select_default:replace(function()
				telescope.actions.close(prompt_bufnr)

				local selection = telescope.action_state.get_selected_entry()
				selection.value[2]()
			end)
			return true
		end,
	}):find()
end

mappings:new{
	description = "LSP actions",
	modes = {
		normal = {["<A-a>"] = lsp_actions},
		visual = "#normal#",
		insert = "#normal#",
	}
}

require("nvim-surround").setup {}

mappings:apply()
