local M = {}

function M.setup(p)
  local hl = vim.api.nvim_set_hl

  -- ╭──────────────────────────────────────────╮
  -- │              Core Editor                  │
  -- ╰──────────────────────────────────────────╯
  hl(0, "Normal", { fg = p.fg, bg = p.bg })
  hl(0, "NormalNC", { fg = p.fg, bg = p.bg })
  hl(0, "NormalFloat", { fg = p.fg, bg = p.bg_panel })
  hl(0, "FloatBorder", { fg = p.border_active, bg = p.bg_panel })
  hl(0, "FloatTitle", { fg = p.primary, bg = p.bg_panel, bold = true })
  hl(0, "Cursor", { fg = p.bg, bg = p.primary })
  hl(0, "lCursor", { fg = p.bg, bg = p.primary })
  hl(0, "CursorLine", { bg = p.bg_element })
  hl(0, "CursorColumn", { bg = p.bg_element })
  hl(0, "CursorLineNr", { fg = p.primary, bold = true })
  hl(0, "LineNr", { fg = p.fg_dark })
  hl(0, "SignColumn", { fg = p.fg_dark, bg = p.bg })
  hl(0, "FoldColumn", { fg = p.fg_dark, bg = p.bg })
  hl(0, "Folded", { fg = p.fg_muted, bg = p.bg_element })
  hl(0, "ColorColumn", { bg = p.bg_element })
  hl(0, "Visual", { bg = p.bg_visual })
  hl(0, "VisualNOS", { bg = p.bg_visual })
  hl(0, "Search", { fg = p.bg, bg = p.yellow })
  hl(0, "IncSearch", { fg = p.bg, bg = p.orange })
  hl(0, "CurSearch", { fg = p.bg, bg = p.orange, bold = true })
  hl(0, "Substitute", { fg = p.bg, bg = p.red })
  hl(0, "MatchParen", { fg = p.primary, bold = true, underline = true })
  hl(0, "Conceal", { fg = p.fg_dark })
  hl(0, "NonText", { fg = p.border })
  hl(0, "SpecialKey", { fg = p.border })
  hl(0, "Whitespace", { fg = p.border })
  hl(0, "EndOfBuffer", { fg = p.bg })
  hl(0, "Directory", { fg = p.secondary })
  hl(0, "Title", { fg = p.primary, bold = true })
  hl(0, "ErrorMsg", { fg = p.red })
  hl(0, "WarningMsg", { fg = p.orange })
  hl(0, "ModeMsg", { fg = p.fg, bold = true })
  hl(0, "MoreMsg", { fg = p.green })
  hl(0, "Question", { fg = p.green })
  hl(0, "WildMenu", { fg = p.bg, bg = p.primary })
  hl(0, "WinBar", { fg = p.fg_muted, bg = p.bg })
  hl(0, "WinBarNC", { fg = p.fg_dark, bg = p.bg })
  hl(0, "WinSeparator", { fg = p.border, bg = p.bg })

  -- ╭──────────────────────────────────────────╮
  -- │             Pmenu / Cmp                   │
  -- ╰──────────────────────────────────────────╯
  hl(0, "Pmenu", { fg = p.fg, bg = p.bg_panel })
  hl(0, "PmenuSel", { fg = p.bg, bg = p.primary })
  hl(0, "PmenuSbar", { bg = p.bg_element })
  hl(0, "PmenuThumb", { bg = p.border_active })

  -- ╭──────────────────────────────────────────╮
  -- │             Statusline / Tabline          │
  -- ╰──────────────────────────────────────────╯
  hl(0, "StatusLine", { fg = p.fg, bg = p.bg_panel })
  hl(0, "StatusLineNC", { fg = p.fg_dark, bg = p.bg_panel })
  hl(0, "TabLine", { fg = p.fg_muted, bg = p.bg_panel })
  hl(0, "TabLineFill", { bg = p.bg })
  hl(0, "TabLineSel", { fg = p.bg, bg = p.primary, bold = true })

  -- ╭──────────────────────────────────────────╮
  -- │          Standard Syntax Groups           │
  -- ╰──────────────────────────────────────────╯
  hl(0, "Comment", { fg = p.fg_muted, italic = true })
  hl(0, "Constant", { fg = p.orange })
  hl(0, "String", { fg = p.green })
  hl(0, "Character", { fg = p.green })
  hl(0, "Number", { fg = p.orange })
  hl(0, "Boolean", { fg = p.orange })
  hl(0, "Float", { fg = p.orange })
  hl(0, "Identifier", { fg = p.red })
  hl(0, "Function", { fg = p.primary })
  hl(0, "Statement", { fg = p.accent })
  hl(0, "Conditional", { fg = p.accent })
  hl(0, "Repeat", { fg = p.accent })
  hl(0, "Label", { fg = p.cyan })
  hl(0, "Operator", { fg = p.cyan })
  hl(0, "Keyword", { fg = p.accent })
  hl(0, "Exception", { fg = p.accent })
  hl(0, "PreProc", { fg = p.yellow })
  hl(0, "Include", { fg = p.accent })
  hl(0, "Define", { fg = p.accent })
  hl(0, "Macro", { fg = p.yellow })
  hl(0, "PreCondit", { fg = p.yellow })
  hl(0, "Type", { fg = p.yellow })
  hl(0, "StorageClass", { fg = p.accent })
  hl(0, "Structure", { fg = p.yellow })
  hl(0, "Typedef", { fg = p.yellow })
  hl(0, "Special", { fg = p.cyan })
  hl(0, "SpecialChar", { fg = p.cyan })
  hl(0, "Tag", { fg = p.primary })
  hl(0, "Delimiter", { fg = p.fg })
  hl(0, "SpecialComment", { fg = p.fg_muted, italic = true })
  hl(0, "Debug", { fg = p.red })
  hl(0, "Underlined", { underline = true })
  hl(0, "Ignore", {})
  hl(0, "Error", { fg = p.red })
  hl(0, "Todo", { fg = p.bg, bg = p.yellow, bold = true })

  -- ╭──────────────────────────────────────────╮
  -- │            Treesitter                     │
  -- ╰──────────────────────────────────────────╯
  hl(0, "@variable", { fg = p.fg })
  hl(0, "@variable.builtin", { fg = p.red })
  hl(0, "@variable.parameter", { fg = p.red, italic = true })
  hl(0, "@variable.member", { fg = p.fg })

  hl(0, "@constant", { fg = p.orange })
  hl(0, "@constant.builtin", { fg = p.orange })
  hl(0, "@constant.macro", { fg = p.yellow })

  hl(0, "@module", { fg = p.secondary })
  hl(0, "@module.builtin", { fg = p.secondary })
  hl(0, "@label", { fg = p.cyan })

  hl(0, "@string", { fg = p.green })
  hl(0, "@string.documentation", { fg = p.green })
  hl(0, "@string.regexp", { fg = p.cyan })
  hl(0, "@string.escape", { fg = p.cyan })
  hl(0, "@string.special", { fg = p.cyan })
  hl(0, "@string.special.symbol", { fg = p.primary })
  hl(0, "@string.special.url", { fg = p.secondary, underline = true })

  hl(0, "@character", { fg = p.green })
  hl(0, "@character.special", { fg = p.cyan })

  hl(0, "@boolean", { fg = p.orange })
  hl(0, "@number", { fg = p.orange })
  hl(0, "@number.float", { fg = p.orange })

  hl(0, "@type", { fg = p.yellow })
  hl(0, "@type.builtin", { fg = p.yellow })
  hl(0, "@type.definition", { fg = p.yellow })

  hl(0, "@attribute", { fg = p.yellow })
  hl(0, "@attribute.builtin", { fg = p.yellow })
  hl(0, "@property", { fg = p.fg })

  hl(0, "@function", { fg = p.primary })
  hl(0, "@function.builtin", { fg = p.primary })
  hl(0, "@function.call", { fg = p.primary })
  hl(0, "@function.macro", { fg = p.yellow })
  hl(0, "@function.method", { fg = p.primary })
  hl(0, "@function.method.call", { fg = p.primary })

  hl(0, "@constructor", { fg = p.yellow })
  hl(0, "@operator", { fg = p.cyan })

  hl(0, "@keyword", { fg = p.accent })
  hl(0, "@keyword.coroutine", { fg = p.accent })
  hl(0, "@keyword.function", { fg = p.accent })
  hl(0, "@keyword.operator", { fg = p.cyan })
  hl(0, "@keyword.import", { fg = p.accent })
  hl(0, "@keyword.type", { fg = p.accent })
  hl(0, "@keyword.modifier", { fg = p.accent })
  hl(0, "@keyword.repeat", { fg = p.accent })
  hl(0, "@keyword.return", { fg = p.accent })
  hl(0, "@keyword.debug", { fg = p.red })
  hl(0, "@keyword.exception", { fg = p.accent })
  hl(0, "@keyword.conditional", { fg = p.accent })
  hl(0, "@keyword.conditional.ternary", { fg = p.cyan })
  hl(0, "@keyword.directive", { fg = p.yellow })
  hl(0, "@keyword.directive.define", { fg = p.yellow })

  hl(0, "@punctuation.delimiter", { fg = p.fg })
  hl(0, "@punctuation.bracket", { fg = p.fg })
  hl(0, "@punctuation.special", { fg = p.cyan })

  hl(0, "@comment", { fg = p.fg_muted, italic = true })
  hl(0, "@comment.documentation", { fg = p.fg_muted, italic = true })
  hl(0, "@comment.error", { fg = p.red })
  hl(0, "@comment.warning", { fg = p.orange })
  hl(0, "@comment.todo", { fg = p.yellow })
  hl(0, "@comment.note", { fg = p.cyan })

  hl(0, "@markup.strong", { bold = true })
  hl(0, "@markup.italic", { italic = true })
  hl(0, "@markup.strikethrough", { strikethrough = true })
  hl(0, "@markup.underline", { underline = true })
  hl(0, "@markup.heading", { fg = p.accent, bold = true })
  hl(0, "@markup.heading.1", { fg = p.accent, bold = true })
  hl(0, "@markup.heading.2", { fg = p.primary, bold = true })
  hl(0, "@markup.heading.3", { fg = p.secondary, bold = true })
  hl(0, "@markup.heading.4", { fg = p.yellow, bold = true })
  hl(0, "@markup.heading.5", { fg = p.cyan, bold = true })
  hl(0, "@markup.heading.6", { fg = p.green, bold = true })
  hl(0, "@markup.quote", { fg = p.yellow, italic = true })
  hl(0, "@markup.math", { fg = p.cyan })
  hl(0, "@markup.link", { fg = p.primary, underline = true })
  hl(0, "@markup.link.label", { fg = p.cyan })
  hl(0, "@markup.link.url", { fg = p.secondary, underline = true })
  hl(0, "@markup.raw", { fg = p.green })
  hl(0, "@markup.raw.block", { fg = p.fg })
  hl(0, "@markup.list", { fg = p.primary })
  hl(0, "@markup.list.checked", { fg = p.green })
  hl(0, "@markup.list.unchecked", { fg = p.fg_muted })

  hl(0, "@tag", { fg = p.primary })
  hl(0, "@tag.attribute", { fg = p.yellow })
  hl(0, "@tag.delimiter", { fg = p.fg_muted })

  -- ╭──────────────────────────────────────────╮
  -- │          LSP Semantic Tokens              │
  -- ╰──────────────────────────────────────────╯
  hl(0, "@lsp.type.class", { fg = p.yellow })
  hl(0, "@lsp.type.decorator", { fg = p.yellow })
  hl(0, "@lsp.type.enum", { fg = p.yellow })
  hl(0, "@lsp.type.enumMember", { fg = p.orange })
  hl(0, "@lsp.type.function", { fg = p.primary })
  hl(0, "@lsp.type.interface", { fg = p.yellow })
  hl(0, "@lsp.type.keyword", { fg = p.accent })
  hl(0, "@lsp.type.macro", { fg = p.yellow })
  hl(0, "@lsp.type.method", { fg = p.primary })
  hl(0, "@lsp.type.namespace", { fg = p.secondary })
  hl(0, "@lsp.type.parameter", { fg = p.red, italic = true })
  hl(0, "@lsp.type.property", { fg = p.fg })
  hl(0, "@lsp.type.struct", { fg = p.yellow })
  hl(0, "@lsp.type.type", { fg = p.yellow })
  hl(0, "@lsp.type.typeParameter", { fg = p.yellow })
  hl(0, "@lsp.type.variable", { fg = p.fg })

  -- ╭──────────────────────────────────────────╮
  -- │              Diagnostics                  │
  -- ╰──────────────────────────────────────────╯
  hl(0, "DiagnosticError", { fg = p.red })
  hl(0, "DiagnosticWarn", { fg = p.orange })
  hl(0, "DiagnosticInfo", { fg = p.cyan })
  hl(0, "DiagnosticHint", { fg = p.secondary })
  hl(0, "DiagnosticOk", { fg = p.green })
  hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = p.red })
  hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = p.orange })
  hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = p.cyan })
  hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = p.secondary })
  hl(0, "DiagnosticUnderlineOk", { undercurl = true, sp = p.green })
  hl(0, "DiagnosticVirtualTextError", { fg = p.red, bg = p.bg_element })
  hl(0, "DiagnosticVirtualTextWarn", { fg = p.orange, bg = p.bg_element })
  hl(0, "DiagnosticVirtualTextInfo", { fg = p.cyan, bg = p.bg_element })
  hl(0, "DiagnosticVirtualTextHint", { fg = p.secondary, bg = p.bg_element })

  -- ╭──────────────────────────────────────────╮
  -- │             LSP References               │
  -- ╰──────────────────────────────────────────╯
  hl(0, "LspReferenceText", { bg = p.bg_surface })
  hl(0, "LspReferenceRead", { bg = p.bg_surface })
  hl(0, "LspReferenceWrite", { bg = p.bg_surface })
  hl(0, "LspSignatureActiveParameter", { fg = p.primary, bold = true })
  hl(0, "LspInfoBorder", { fg = p.border_active })
  hl(0, "LspInlayHint", { fg = p.fg_dark, italic = true })

  -- ╭──────────────────────────────────────────╮
  -- │                Diff                       │
  -- ╰──────────────────────────────────────────╯
  hl(0, "DiffAdd", { bg = p.diff_add_bg })
  hl(0, "DiffChange", { bg = p.diff_change_bg })
  hl(0, "DiffDelete", { fg = p.diff_remove, bg = p.diff_remove_bg })
  hl(0, "DiffText", { bg = p.bg_visual })
  hl(0, "diffAdded", { fg = p.diff_add })
  hl(0, "diffRemoved", { fg = p.diff_remove })
  hl(0, "diffChanged", { fg = p.secondary })
  hl(0, "diffFile", { fg = p.primary })
  hl(0, "diffNewFile", { fg = p.green })
  hl(0, "diffOldFile", { fg = p.red })

  -- ╭──────────────────────────────────────────╮
  -- │             GitSigns                      │
  -- ╰──────────────────────────────────────────╯
  hl(0, "GitSignsAdd", { fg = p.green })
  hl(0, "GitSignsChange", { fg = p.secondary })
  hl(0, "GitSignsDelete", { fg = p.red })
  hl(0, "GitSignsCurrentLineBlame", { fg = p.fg_dark, italic = true })

  -- ╭──────────────────────────────────────────╮
  -- │             Neo-tree                      │
  -- ╰──────────────────────────────────────────╯
  hl(0, "NeoTreeNormal", { fg = p.fg, bg = p.bg_panel })
  hl(0, "NeoTreeNormalNC", { fg = p.fg, bg = p.bg_panel })
  hl(0, "NeoTreeDirectoryIcon", { fg = p.secondary })
  hl(0, "NeoTreeDirectoryName", { fg = p.secondary })
  hl(0, "NeoTreeRootName", { fg = p.primary, bold = true })
  hl(0, "NeoTreeFileName", { fg = p.fg })
  hl(0, "NeoTreeFileIcon", { fg = p.fg_muted })
  hl(0, "NeoTreeGitAdded", { fg = p.green })
  hl(0, "NeoTreeGitConflict", { fg = p.red })
  hl(0, "NeoTreeGitDeleted", { fg = p.red })
  hl(0, "NeoTreeGitModified", { fg = p.secondary })
  hl(0, "NeoTreeGitUntracked", { fg = p.yellow })
  hl(0, "NeoTreeIndentMarker", { fg = p.border })
  hl(0, "NeoTreeWinSeparator", { fg = p.border, bg = p.bg })
  hl(0, "NeoTreeCursorLine", { bg = p.bg_element })

  -- ╭──────────────────────────────────────────╮
  -- │           Telescope / fzf-lua            │
  -- ╰──────────────────────────────────────────╯
  hl(0, "TelescopeNormal", { fg = p.fg, bg = p.bg_panel })
  hl(0, "TelescopeBorder", { fg = p.border_active, bg = p.bg_panel })
  hl(0, "TelescopeTitle", { fg = p.primary, bold = true })
  hl(0, "TelescopePromptNormal", { fg = p.fg, bg = p.bg_element })
  hl(0, "TelescopePromptBorder", { fg = p.border_active, bg = p.bg_element })
  hl(0, "TelescopePromptTitle", { fg = p.bg, bg = p.primary, bold = true })
  hl(0, "TelescopePromptPrefix", { fg = p.primary })
  hl(0, "TelescopeResultsNormal", { fg = p.fg, bg = p.bg_panel })
  hl(0, "TelescopeResultsBorder", { fg = p.border_active, bg = p.bg_panel })
  hl(0, "TelescopePreviewNormal", { fg = p.fg, bg = p.bg_panel })
  hl(0, "TelescopePreviewBorder", { fg = p.border_active, bg = p.bg_panel })
  hl(0, "TelescopePreviewTitle", { fg = p.bg, bg = p.green, bold = true })
  hl(0, "TelescopeSelection", { fg = p.fg, bg = p.bg_highlight })
  hl(0, "TelescopeSelectionCaret", { fg = p.primary })
  hl(0, "TelescopeMatching", { fg = p.primary, bold = true })
  hl(0, "FzfLuaNormal", { link = "TelescopeNormal" })
  hl(0, "FzfLuaBorder", { link = "TelescopeBorder" })
  hl(0, "FzfLuaTitle", { link = "TelescopeTitle" })

  -- ╭──────────────────────────────────────────╮
  -- │            Which-key                      │
  -- ╰──────────────────────────────────────────╯
  hl(0, "WhichKey", { fg = p.primary })
  hl(0, "WhichKeyGroup", { fg = p.secondary })
  hl(0, "WhichKeyDesc", { fg = p.fg })
  hl(0, "WhichKeySeparator", { fg = p.fg_dark })
  hl(0, "WhichKeyFloat", { bg = p.bg_panel })
  hl(0, "WhichKeyBorder", { fg = p.border_active, bg = p.bg_panel })
  hl(0, "WhichKeyValue", { fg = p.fg_muted })

  -- ╭──────────────────────────────────────────╮
  -- │            Noice / Notify                 │
  -- ╰──────────────────────────────────────────╯
  hl(0, "NoiceCmdlinePopup", { fg = p.fg, bg = p.bg_panel })
  hl(0, "NoiceCmdlinePopupBorder", { fg = p.primary })
  hl(0, "NoiceCmdlineIcon", { fg = p.primary })
  hl(0, "NoiceMini", { fg = p.fg, bg = p.bg_element })
  hl(0, "NotifyERRORBorder", { fg = p.red })
  hl(0, "NotifyWARNBorder", { fg = p.orange })
  hl(0, "NotifyINFOBorder", { fg = p.cyan })
  hl(0, "NotifyDEBUGBorder", { fg = p.fg_muted })
  hl(0, "NotifyTRACEBorder", { fg = p.accent })
  hl(0, "NotifyERRORIcon", { fg = p.red })
  hl(0, "NotifyWARNIcon", { fg = p.orange })
  hl(0, "NotifyINFOIcon", { fg = p.cyan })
  hl(0, "NotifyDEBUGIcon", { fg = p.fg_muted })
  hl(0, "NotifyTRACEIcon", { fg = p.accent })
  hl(0, "NotifyERRORTitle", { fg = p.red })
  hl(0, "NotifyWARNTitle", { fg = p.orange })
  hl(0, "NotifyINFOTitle", { fg = p.cyan })
  hl(0, "NotifyDEBUGTitle", { fg = p.fg_muted })
  hl(0, "NotifyTRACETitle", { fg = p.accent })

  -- ╭──────────────────────────────────────────╮
  -- │         Trouble / Diagnostics list        │
  -- ╰──────────────────────────────────────────╯
  hl(0, "TroubleNormal", { fg = p.fg, bg = p.bg_panel })
  hl(0, "TroubleCount", { fg = p.accent, bg = p.bg_surface })
  hl(0, "TroubleText", { fg = p.fg })

  -- ╭──────────────────────────────────────────╮
  -- │           Dashboard / Alpha               │
  -- ╰──────────────────────────────────────────╯
  hl(0, "DashboardHeader", { fg = p.primary })
  hl(0, "DashboardFooter", { fg = p.fg_muted, italic = true })
  hl(0, "DashboardIcon", { fg = p.secondary })
  hl(0, "DashboardDesc", { fg = p.fg })
  hl(0, "DashboardKey", { fg = p.primary })
  hl(0, "DashboardShortCut", { fg = p.accent })

  -- ╭──────────────────────────────────────────╮
  -- │           Snacks (LazyVim)                │
  -- ╰──────────────────────────────────────────╯
  hl(0, "SnacksNormal", { fg = p.fg, bg = p.bg_panel })
  hl(0, "SnacksDashboardHeader", { fg = p.primary })
  hl(0, "SnacksDashboardFooter", { fg = p.fg_muted, italic = true })
  hl(0, "SnacksDashboardIcon", { fg = p.secondary })
  hl(0, "SnacksDashboardDesc", { fg = p.fg })
  hl(0, "SnacksDashboardKey", { fg = p.primary })
  hl(0, "SnacksDashboardSpecial", { fg = p.accent })
  hl(0, "SnacksIndent", { fg = p.border })
  hl(0, "SnacksIndentScope", { fg = p.accent })
  hl(0, "SnacksNotifierInfo", { fg = p.cyan })
  hl(0, "SnacksNotifierWarn", { fg = p.orange })
  hl(0, "SnacksNotifierError", { fg = p.red })

  -- ╭──────────────────────────────────────────╮
  -- │          Indent Blankline                 │
  -- ╰──────────────────────────────────────────╯
  hl(0, "IblIndent", { fg = p.bg_surface })
  hl(0, "IblScope", { fg = p.accent })

  -- ╭──────────────────────────────────────────╮
  -- │             Flash.nvim                    │
  -- ╰──────────────────────────────────────────╯
  hl(0, "FlashBackdrop", { fg = p.fg_dark })
  hl(0, "FlashLabel", { fg = p.bg, bg = p.primary, bold = true })
  hl(0, "FlashMatch", { fg = p.fg, bg = p.bg_visual })
  hl(0, "FlashCurrent", { fg = p.fg, bg = p.bg_highlight })

  -- ╭──────────────────────────────────────────╮
  -- │            Lazy.nvim UI                   │
  -- ╰──────────────────────────────────────────╯
  hl(0, "LazyH1", { fg = p.bg, bg = p.primary, bold = true })
  hl(0, "LazyH2", { fg = p.primary, bold = true })
  hl(0, "LazyButton", { fg = p.fg, bg = p.bg_surface })
  hl(0, "LazyButtonActive", { fg = p.bg, bg = p.primary })
  hl(0, "LazyComment", { fg = p.fg_muted })
  hl(0, "LazyNormal", { fg = p.fg, bg = p.bg_panel })
  hl(0, "LazySpecial", { fg = p.secondary })
  hl(0, "LazyReasonPlugin", { fg = p.accent })
  hl(0, "LazyReasonEvent", { fg = p.yellow })
  hl(0, "LazyReasonCmd", { fg = p.cyan })
  hl(0, "LazyReasonFt", { fg = p.green })
  hl(0, "LazyReasonKeys", { fg = p.primary })

  -- ╭──────────────────────────────────────────╮
  -- │              Mason                        │
  -- ╰──────────────────────────────────────────╯
  hl(0, "MasonNormal", { fg = p.fg, bg = p.bg_panel })
  hl(0, "MasonHeader", { fg = p.bg, bg = p.primary, bold = true })
  hl(0, "MasonHighlight", { fg = p.secondary })
  hl(0, "MasonHighlightBlock", { fg = p.bg, bg = p.secondary })
  hl(0, "MasonHighlightBlockBold", { fg = p.bg, bg = p.secondary, bold = true })
  hl(0, "MasonMuted", { fg = p.fg_muted })
  hl(0, "MasonMutedBlock", { fg = p.bg, bg = p.fg_muted })

  -- ╭──────────────────────────────────────────╮
  -- │        Nvim-cmp / blink.cmp               │
  -- ╰──────────────────────────────────────────╯
  hl(0, "CmpItemAbbr", { fg = p.fg })
  hl(0, "CmpItemAbbrDeprecated", { fg = p.fg_dark, strikethrough = true })
  hl(0, "CmpItemAbbrMatch", { fg = p.primary, bold = true })
  hl(0, "CmpItemAbbrMatchFuzzy", { fg = p.primary })
  hl(0, "CmpItemKind", { fg = p.accent })
  hl(0, "CmpItemKindFunction", { fg = p.primary })
  hl(0, "CmpItemKindMethod", { fg = p.primary })
  hl(0, "CmpItemKindVariable", { fg = p.red })
  hl(0, "CmpItemKindKeyword", { fg = p.accent })
  hl(0, "CmpItemKindText", { fg = p.fg })
  hl(0, "CmpItemKindField", { fg = p.green })
  hl(0, "CmpItemKindClass", { fg = p.yellow })
  hl(0, "CmpItemKindInterface", { fg = p.yellow })
  hl(0, "CmpItemKindModule", { fg = p.secondary })
  hl(0, "CmpItemKindSnippet", { fg = p.cyan })
  hl(0, "CmpItemMenu", { fg = p.fg_muted })
  hl(0, "BlinkCmpMenu", { fg = p.fg, bg = p.bg_panel })
  hl(0, "BlinkCmpMenuBorder", { fg = p.border_active, bg = p.bg_panel })
  hl(0, "BlinkCmpMenuSelection", { bg = p.bg_highlight })
  hl(0, "BlinkCmpLabel", { fg = p.fg })
  hl(0, "BlinkCmpLabelMatch", { fg = p.primary, bold = true })
  hl(0, "BlinkCmpKind", { fg = p.accent })

  -- ╭──────────────────────────────────────────╮
  -- │            Mini (statusline)              │
  -- ╰──────────────────────────────────────────╯
  hl(0, "MiniStatuslineDevinfo", { fg = p.fg, bg = p.bg_surface })
  hl(0, "MiniStatuslineFileinfo", { fg = p.fg, bg = p.bg_surface })
  hl(0, "MiniStatuslineFilename", { fg = p.fg_muted, bg = p.bg_panel })
  hl(0, "MiniStatuslineInactive", { fg = p.fg_dark, bg = p.bg_panel })
  hl(0, "MiniStatuslineModeNormal", { fg = p.bg, bg = p.secondary, bold = true })
  hl(0, "MiniStatuslineModeInsert", { fg = p.bg, bg = p.green, bold = true })
  hl(0, "MiniStatuslineModeVisual", { fg = p.bg, bg = p.accent, bold = true })
  hl(0, "MiniStatuslineModeReplace", { fg = p.bg, bg = p.red, bold = true })
  hl(0, "MiniStatuslineModeCommand", { fg = p.bg, bg = p.primary, bold = true })

  -- ╭──────────────────────────────────────────╮
  -- │             Lualine colors                │
  -- ╰──────────────────────────────────────────╯
  -- (lualine reads these from the theme table, see init.lua)

  -- ╭──────────────────────────────────────────╮
  -- │            Illuminate                     │
  -- ╰──────────────────────────────────────────╯
  hl(0, "IlluminatedWordText", { bg = p.bg_surface })
  hl(0, "IlluminatedWordRead", { bg = p.bg_surface })
  hl(0, "IlluminatedWordWrite", { bg = p.bg_surface })

  -- ╭──────────────────────────────────────────╮
  -- │            Navic (breadcrumbs)            │
  -- ╰──────────────────────────────────────────╯
  hl(0, "NavicText", { fg = p.fg })
  hl(0, "NavicSeparator", { fg = p.fg_dark })
  hl(0, "NavicIconsFile", { fg = p.fg })
  hl(0, "NavicIconsModule", { fg = p.secondary })
  hl(0, "NavicIconsNamespace", { fg = p.secondary })
  hl(0, "NavicIconsPackage", { fg = p.secondary })
  hl(0, "NavicIconsClass", { fg = p.yellow })
  hl(0, "NavicIconsMethod", { fg = p.primary })
  hl(0, "NavicIconsFunction", { fg = p.primary })
  hl(0, "NavicIconsVariable", { fg = p.red })
  hl(0, "NavicIconsConstant", { fg = p.orange })
  hl(0, "NavicIconsString", { fg = p.green })
  hl(0, "NavicIconsBoolean", { fg = p.orange })
  hl(0, "NavicIconsKey", { fg = p.accent })
  hl(0, "NavicIconsEnum", { fg = p.yellow })
  hl(0, "NavicIconsStruct", { fg = p.yellow })
end

return M
