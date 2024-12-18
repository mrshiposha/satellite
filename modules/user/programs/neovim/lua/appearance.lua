local plugins = {
	transparent = require("transparent"),
	nordic = require("nordic"),
	notify = require("notify"),
	noice = require("noice"),
	galaxyline = {
		core = require("galaxyline"),
		section = require("galaxyline").section,
		condition = require("galaxyline.condition")
	},
	dressing = require("dressing")
}

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.list = true
vim.opt.listchars = {
	tab = "→ ",
	trail = "·",
	space = "·",
	nbsp = "␣",
	eol = "¬",
	extends = "⟩",
	precedes = "⟨"
}

vim.g.rust_recommended_style = false

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.nix", "*.lua" },
	callback = function ()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.js", "*.ts", "*.json" },
	callback = function ()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end
})

-- Create an autocommand group
local autoreload_group = vim.api.nvim_create_augroup('AutoReload', { clear = true })

-- Add autocommands to the group
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
		group = autoreload_group,
		pattern = '*',
		command = 'checktime',
})

-- Set the autoread option to true
vim.opt.autoread = true

-- Check for file changes periodically
vim.api.nvim_create_autocmd('CursorHold', {
		group = autoreload_group,
		pattern = '*',
		command = 'checktime',
})

vim.g.neovide_text_gamma = 0.8
vim.g.neovide_text_contrast = 0.1 -- Will work with 0.13.1, see https://github.com/neovide/neovide/pull/2510

vim.g.neovide_fullscreen = false
vim.g.neovide_remember_window_size = false
vim.g.neovide_transparency = 0.7

if vim.g.neovide then
	vim.g.neovide_fullscreen = false
	vim.g.neovide_remember_window_size = false
	vim.g.neovide_transparency = 0.7
else
	plugins.transparent.setup {}
	vim.g.transparent_enabled = true
end

plugins.nordic.colorscheme({
	underline_option = 'none',
	italic = true,
	italic_comments = false,
	minimal_mode = false,
	alternate_backgrounds = false
})
plugins.notify.setup {top_down = false}
vim.notify = plugins.notify

plugins.noice.setup {}

-- TODO notify macro recording

plugins.galaxyline.core.short_line_list = {"NvimTree"}
plugins.galaxyline.section.left[1] = {
	ViMode = {
		provider = function()
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
				[""] = "select block" -- This is a special character for select block mode
			}

			return "(- " .. (mode_names[vim.fn.mode()] or "unknown") .. " -)";
		end,
		separator = " "
	}
}
plugins.galaxyline.section.left[2] = {
	FileIcon = {
		provider = "FileIcon",
		condition = plugins.galaxyline.condition.buffer_not_empty
	}
}
plugins.galaxyline.section.left[3] = {
	FileName = {
		provider = "FileName",
		condition = plugins.galaxyline.condition.buffer_not_empty
	}
}
plugins.galaxyline.section.left[4] = {
	MacroRecording = {
		provider = function ()
			local reg_recording = vim.fn.reg_recording()

			if reg_recording == "" then
				return ""
			else
				return " // recording @".. reg_recording
			end
		end,
	}
}
plugins.galaxyline.section.mid[1] = {
	GitBranch = {
		provider = 'GitBranch',
		icon = "  ",
		condition = plugins.galaxyline.condition.check_git_workspace
	}
}
plugins.galaxyline.section.right[1] = {
	PerCent = {provider = "LinePercent", separator = " "}
}
plugins.galaxyline.section.right[2] = {
	FileEncode = {provider = "FileEncode", separator = " "}
}
vim.api.nvim_set_hl(0, "StatusLine", {bg = "NONE"})

plugins.dressing.setup {}
