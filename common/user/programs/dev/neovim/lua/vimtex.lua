vim.cmd("filetype plugin indent on")

vim.g.vimtex_view_method = "zathura";
vim.g.vimtex_compiler_latexmk = {
	aux_dir = './build/aux',
	out_dir = './build/out',
};
vim.g.vimtex_view_use_temp_files = true
