return {
    list_tab_wins = function()
        local wins = {}
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
	    table.insert(wins, { buf = buf, id = win })
        end

        return wins
    end,
}

