require("flatten").setup({
    window = {
        open = "alternate",
    },
    one_per = {
        wezterm = true,
    },
})
vim.api.nvim_create_autocmd("TermOpen", {
    command = "startinsert",
})
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function ()
	if vim.bo.buftype == "terminal" then
	    vim.api.nvim_command("startinsert")
	end
    end
})

