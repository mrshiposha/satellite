vim.o.showtabline = 2
require("tabby.tabline").set(function(line)
	local theme = {
		fill = 'TabLineFill',
		current_tab = 'TabLineSel',
		tab = 'TabLine'
	}

	return {
		line.tabs().foreach(function(tab)
			local hl = tab.is_current() and theme.current_tab or theme.tab
			local winfiles = {}
			local terminals = 0
			local extra = 0

			local max_filenames = 3

			line.wins_in_tab(tab.id, function(win)
				return not string.match(win.buf_name(), "NvimTree")
			end).foreach(function(win)

				if #winfiles < max_filenames then
					local buf_type = win.buf().type()

					if buf_type == "terminal" then
						terminals = terminals + 1
					else
						local name = buf_type == "" and win.buf_name() or buf_type
						table.insert(winfiles, win.file_icon() .. " " .. name)
					end
				else
					if win.buf().type() == "terminal" then
						terminals = terminals + 1
					else
						extra = extra + 1
					end
				end
			end)

			if terminals > 0 then
				if #winfiles == max_filenames then
					table.remove(winfiles, max_filenames)
					extra = extra + 1
				end

				local term_num = terminals > 1 and "s: " .. terminals or "";
				table.insert(winfiles, " terminal" .. term_num)
			end

			if extra > 0 then table.insert(winfiles, "+" .. extra) end
			local filenames = table.concat(winfiles, " | ")

			return {
				line.sep("▓", hl, theme.fill),
				tab.is_current() and "" or "",
				tab.number(),
				filenames,
				tab.close_btn(""),
				line.sep("▓", hl, theme.fill),
				hl = hl,
				margin = " "
			}
		end),
		hl = theme.fill
	}
end)
require("nvim-tree").setup {
	tab = {sync = {open = true, close = true}},
	update_focused_file = {enable = true, update_root = {enable = true}},
	view = {preserve_window_proportions = true, width = {min = 40}},
	renderer = {
		indent_width = 1,
		indent_markers = {
			enable = true,
			icons = {
				corner = "╰",
				edge = "┊",
				item = "│",
				bottom = "…",
				none = " "
			}
		},
		highlight_git = "name",
		highlight_modified = "icon",
		icons = {git_placement = "after"}
	},
	modified = {enable = true, show_on_open_dirs = false},
	git = {enable = true, show_on_open_dirs = false},
	trash = {cmd = "trash"},
	live_filter = {always_show_folders = false},
	filters = {
		dotfiles = true,
	},
	on_attach = function(buf)
		local api = require("nvim-tree.api")
		local function keymap(key, action, opts)
			opts = opts or {buffer = buf, silent = true}
			vim.keymap.set("n", key, action, opts)
		end

		keymap(".", function()
			local node = api.tree.get_node_under_cursor()

			if node.type == "directory" then
				api.tree.change_root_to_node()
				vim.api.nvim_set_current_dir(node.absolute_path)
			end
		end)
		keymap("<Space>", api.node.open.edit)
		keymap("<CR>", api.node.open.tab_drop)
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
	end
}

vim.api.nvim_set_hl(0, "NvimTreeNormal", {bg = "NONE"})

vim.opt.splitbelow = true
vim.opt.splitright = true
