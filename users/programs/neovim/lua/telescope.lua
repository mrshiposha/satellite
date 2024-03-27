require("plenary")
require("telescope").setup({
    defaults = {
	mappings = {
	    i = {
		["<C-h>"] = "which_key",
		["<C-v>"] = function(prompt_bufnr)
		  local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
		  local text = vim.fn.getreg('+')
		  current_picker:set_prompt(text, false)
		end,
	    }
	}
    }
})
