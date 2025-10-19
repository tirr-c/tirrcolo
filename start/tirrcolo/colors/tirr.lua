assert(vim.opt.termguicolors, "'termguicolors' should be set")

local colors = require('tirrcolo').make_palette(vim.g.tirrcolo_p3)

local highlights = {
  -- Basic editor groups
  Normal = { fg = colors.gray['50'], bg = colors.gray['950'] },
  NormalFloat = { fg = colors.gray['50'], bg = colors.gray['900'] },
  Title = { bold = true, fg = colors.gray['50'] },
  FloatTitle = { bold = true, fg = colors.gray['50'], bg = colors.gray['900'] },

  Conceal = { fg = colors.gray['700'] },
  NonText = { fg = colors.gray['700'] },

  Cursor = { fg = 'bg', bg = 'fg' },
  lCursor = { fg = 'bg', bg = 'fg' },
  CursorIM = { link = 'Cursor' },

  ColorColumn = { bg = colors.gray['900'] },
  CursorLine = { bg = colors.gray['1000'] },
  CursorColumn = { link = 'CursorLine' },

  Search = { bg = colors.yellow['800'] },
  CurSearch = { bg = colors.yellow['600'] },

  DiffAdd = { bg = colors.green['800'] },
  DiffDelete = { bg = colors.red['800'] },
  DiffChange = { bg = colors.gray['900'] },
  DiffText = { bg = colors.flamingo['800'] },

  ErrorMsg = { fg = colors.red['300'] },
  WarningMsg = { fg = colors.yellow['300'] },

  LineNr = { fg = colors.make('yellow', '600', 0.7), bg = colors.gray['1000'] },
  CursorLineNr = { fg = colors.make('yellow', '500', 0.9), bg = colors.gray['1000'] },
  Folded = { fg = colors.make('yellow', '600', 0.9), bg = colors.gray['1000'] },
  FoldColumn = { bg = colors.gray['1000'] },
  SignColumn = { bg = colors.gray['1000'] },

  MatchParen = { bold = true, bg = colors.gray['900'] },

  ModeMsg = { fg = colors.bronze['300'] },
  MoreMsg = { fg = colors.bronze['300'] },
  Question = { fg = colors.bronze['300'] },

  Pmenu = { fg = colors.gray['50'], bg = colors.gray['900'] },
  PmenuSel = { fg = colors.gray['950'], bg = colors.gray['100'], blend = 0 },
  PmenuKind = { fg = colors.bronze['300'], bg = colors.gray['900'] },
  PmenuKindSel = { fg = colors.bronze['800'], bg = colors.gray['100'], blend = 0 },
  PmenuExtra = { fg = colors.gray['300'], bg = colors.gray['900'] },
  PmenuExtraSel = { fg = colors.gray['600'], bg = colors.gray['100'], blend = 0 },
  PmenuSbar = { bg = colors.gray['700'] },
  PmenuThumb = { bg = colors.gray['300'] },

  QuickFixLine = { fg = colors.cyan['300'] },

  Visual = { bg = colors.aquamarine['900'] },
  VisualNOS = { bg = colors.gray['900'] },

  -- Standard syntax groups
  Comment = { fg = colors.gray['300'] },

  Constant = { fg = colors.blue['200'] },
  String = { fg = colors.green['300'] },
  Character = { fg = colors.bronze['400'] },
  Number = { fg = colors.yellow['300'] },
  Boolean = { fg = colors.violet['400'] },
  Float = { link = 'Number' },

  Identifier = { fg = colors.make('bronze', '200', 0.8) },
  Function = { fg = colors.yellow['200'] },

  Statement = { bold = true, fg = colors.green['400'] },
  Conditional = { fg = colors.blue['400'] },
  Repeat = { fg = colors.blue['400'] },
  Label = { bold = true, fg = colors.green['300'] },
  Operator = { fg = colors.make('yellow', '200', 0.7) },
  Keyword = { fg = colors.flamingo['400'] },
  Exception = { fg = colors.make('flamingo', '500', 1.3) },

  PreProc = { fg = colors.turmeric['400'] },

  Type = { fg = colors.aquamarine['300'] },

  Special = { fg = colors.bronze['300'] },
  Delimiter = { fg = colors.bronze['500'] },
  Underlined = { underline = true, fg = colors.bronze['300'] },

  Error = { bg = colors.flamingo['800'] },

  Todo = { bold = true, fg = colors.red['400'] },

  Added = { fg = colors.green['300'] },
  Changed = { fg = colors.cyan['300'] },
  Removed = { fg = colors.red['300'] },

  -- Diagnostics
  DiagnosticError = { fg = colors.red['300'] },
  DiagnosticWarn = { fg = colors.yellow['300'] },
  DiagnosticInfo = { fg = colors.cyan['300'] },
  DiagnosticHint = { fg = colors.blue['300'] },
  DiagnosticOk = { fg = colors.green['400'] },
  DiagnosticUnderlineError = { underline = true, sp = colors.red['300'] },
  DiagnosticUnderlineWarn = { underline = true, sp = colors.yellow['300'] },
  DiagnosticUnderlineInfo = { underline = true, sp = colors.cyan['300'] },
  DiagnosticUnderlineHint = { underline = true, sp = colors.blue['300'] },
  DiagnosticUnderlineOk = { underline = true, sp = colors.green['400'] },
  DiagnosticSignError = { fg = colors.red['300'], bg = colors.gray['1000'] },
  DiagnosticSignWarn = { fg = colors.yellow['300'], bg = colors.gray['1000'] },
  DiagnosticSignInfo = { fg = colors.cyan['300'], bg = colors.gray['1000'] },
  DiagnosticSignHint = { fg = colors.blue['300'], bg = colors.gray['1000'] },
  DiagnosticSignOk = { fg = colors.green['400'], bg = colors.gray['1000'] },

  -- treesitter groups
  ['@variable'] = { fg = colors.gray['50'] },

  -- LSP groups
  LspCodeLens = { fg = colors.gray['200'] },
  LspInlayHint = { italic = true, fg = colors.make('cyan', '200', 0.7) },
  LspReferenceText = { bg = colors.gray['800'] },

  -- Language: Rust
  rustEnumVariant = { fg = colors.make('blue', '200', 1.1) },
  ['@lsp.type.const.rust'] = { fg = colors.make('blue', '200', 0.6) },
  ['@lsp.type.constParameter.rust'] = { link = '@lsp.type.const.rust' },
  ['@lsp.type.enumMember.rust'] = { link = 'rustEnumVariant' },
  ['@lsp.type.interface.rust'] = { fg = colors.violet['300'] },
  ['@lsp.type.keyword.rust'] = { link = '@lsp' },
  ['@lsp.type.property.rust'] = { link = '@lsp' },
  ['@lsp.type.namespace.rust'] = { fg = colors.bronze['300'] },
  ['@lsp.type.builtinType.rust'] = { link = 'Type' },
  ['@lsp.type.typeAlias.rust'] = { link = 'Type' },
  ['@lsp.mod.crateRoot.rust'] = { bold = true },
  ['@lsp.mod.unsafe.rust'] = { underline = true, sp = colors.make('flamingo', '500', 1.3) },
  ['@lsp.typemod.comment.documentation.rust'] = { fg = colors.make('bronze', '400', 0.8) },
  ['@lsp.typemod.keyword.crateRoot.rust'] = { link = '@lsp.type.namespace.rust' },
  ['@lsp.typemod.keyword.unsafe.rust'] = { nocombine = true },
}

vim.opt.background = 'dark'
vim.cmd.highlight({ 'clear' })

for hi, opt in pairs(highlights) do
  vim.api.nvim_set_hl(0, hi, opt)
end

local ansi_colors = {
  colors.gray['1000'], colors.red['400'], colors.green['400'], colors.yellow['400'], colors.blue['400'], colors.magenta['400'], colors.cyan['400'], colors.gray['50'],
  colors.gray['900'], colors.red['200'], colors.green['200'], colors.yellow['200'], colors.blue['200'], colors.magenta['200'], colors.cyan['200'], colors.gray['0'],
}
vim.g.terminal_ansi_colors = ansi_colors
for idx, color in pairs(ansi_colors) do
  vim.g['terminal_color_' .. (idx - 1)] = color
end
