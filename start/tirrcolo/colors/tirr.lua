assert(vim.opt.termguicolors, "'termguicolors' should be set")

local colors = require('tirrcolo').make_palette(vim.g.tirrcolo_p3)

vim.opt.background = 'dark'
vim.cmd.highlight({ 'clear' })
vim.api.nvim_set_hl(0, 'Normal', { fg = colors.gray['100'], bg = colors.gray['950'] })
