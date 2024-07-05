local plugins = {
    transparent = require("transparent"),
    nordic = require("nordic"), 
}

vim.o.guifont = "serif:#-subpixelantialias";
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
