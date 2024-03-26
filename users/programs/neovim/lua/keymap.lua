local keymap = vim.keymap.set

function keymap (modes, key, action, options)
    if options == nil then
        options = { noremap = true, silent = true }
    end
    vim.keymap.set(modes, key, action, options)
end

keymap({"n", "v"}, "-", "$")

keymap({"n", "i", "v"}, "<C-s>", "<cmd>w<cr>")
keymap({"n", "i", "v", "t"}, "<C-q>", "<cmd>q<cr>")

keymap({"n"}, "<ESC>", "<cmd>noh<cr>")

keymap({"i"}, "<C-c>", "<ESC>\"+yi")
keymap({"i"}, "<C-v>", "<ESC>\"+pa")

keymap({"n", "i", "v"}, "<C-z>", "<cmd>u<cr>")
keymap({"i"}, "<C-r>", "<ESC><C-r>i")

keymap({"n", "i", "v"}, "<C-Tab>", "<cmd>BufferNext<cr>")
keymap({"n", "i", "v"}, "<C-S-Tab>", "<cmd>BufferPrevious<cr>")
keymap({"n", "i", "v"}, "<C-w>", "<cmd>BufferClose<cr>")

keymap({"n", "v"}, "<Tab><Left>", "<C-w><Left>")
keymap({"n", "v"}, "<Tab><Right>", "<C-w><Right>")
keymap({"n", "v"}, "<Tab><Up>", "<C-w><Up>")
keymap({"n", "v"}, "<Tab><Down>", "<C-w><Down>")

keymap({"n", "i", "v"}, "<C-b>", "<cmd>CHADopen<cr>")

keymap({"n", "v"}, "<C-Left>", "b")
keymap({"i"}, "<C-Left>", "<C-O>b")
keymap({"n", "v"}, "<C-Right>", "e")
keymap({"i"}, "<C-Right>", "<C-O>e<Right>")
keymap({"n", "i", "v"}, "<C-S-Up>", "<C-Y>")
keymap({"n", "i", "v"}, "<C-S-Down>", "<C-E>")

keymap({"n", "i"}, "<S-Up>", "<ESC>v<Up>")
keymap({"v"}, "<S-Up>", "<Up>")
keymap({"n", "i"}, "<S-Down>", "<ESC>v<Down>")
keymap({"v"}, "<S-Down>", "<Down>")
keymap({"n", "i", "v"}, "<C-S-Left>", "<ESC>vb")
keymap({"n", "i", "v"}, "<C-S-Right>", "<ESC>ve")

keymap({"v"}, "<A-Right>", ">gv")
keymap({"n", "i"}, "<A-Right>", ">>")
keymap({"v"}, "<A-Left>", "<gv")
keymap({"n", "i"}, "<A-Left>", "<<")

keymap({"v"}, "<A-Up>", ":m '<-2<cr>gv=gv")
keymap({"n", "i"}, "<A-Up>", "<cmd>m .-2<cr>")
keymap({"v"}, "<A-Down>", ":m '>+1<cr>gv=gv")
keymap({"n", "i"}, "<A-Down>", "<cmd>m .+1<cr>")

keymap({"n", "i", "v"}, "<A-s>", "<cmd>split<cr><C-w><C-w>")
keymap({"n", "i", "v"}, "<A-v>", "<cmd>vsplit<cr><C-w><C-w>")

keymap({"n", "i", "v", "t"}, "<C-`>", "<cmd>ToggleTerm<cr>")
keymap({"t"}, "<A-s>", "<cmd>+1ToggleTerm direction=horizontal<cr>")
keymap({"t"}, "<A-v>", "<cmd>+1ToggleTerm direction=vertical<cr>")
keymap({"t"}, "<ESC>", "<C-\\><C-n>")
keymap({"t"}, "<C-w><Left>", "<C-\\><C-n><C-w><Left>")
keymap({"t"}, "<C-w><Right>", "<C-\\><C-n><C-w><Right>")
keymap({"t"}, "<C-w><Up>", "<C-\\><C-n><C-w><Up>")
keymap({"t"}, "<C-w><Down>", "<C-\\><C-n><C-w><Down>")
