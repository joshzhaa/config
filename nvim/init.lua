-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- enabling LSPs not handled inside LazyVim
vim.lsp.enable("nixd")
