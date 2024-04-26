-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

-- See: https://github.com/brainfucksec/neovim-lua#appearance

-- Load nvim color scheme:
-- Change the "require" values with your color scheme
-- Available color schemes: onedark, monokai, rose-pine
-- local status_ok, color_scheme = pcall(require, 'tokyonight')
-- if not status_ok then
--   return
-- end

-- Note: The instruction to load the color scheme may vary.
-- See the README of the selected color scheme for the instruction
-- to use.
-- e.g.: require('color_scheme').setup{}, vim.cmd('color_scheme')

-- OneDark styles: dark, darker, cool, deep, warm, warmer, light

-- require('catppuccin').setup {
--   flavour = 'frappe',
--   transparent_background = true,
-- }
--
-- vim.cmd[[
--     colorscheme catppuccin
--     hi! NvimTreeExecFile gui=NONE cterm=NONE
--     hi! SpellCap gui=NONE cterm=NONE
-- ]]

-- TOKYO NIGHT
require('tokyonight').setup({
  style = "moon",
  transparent = true,
  styles = {
    sidebars = 'transparent'
  }
})

vim.cmd[[
colorscheme tokyonight-moon
hi! LineNr guifg=#485f72
hi! CursorLineNr guifg=#848cba
hi! WinSeparator guifg=#647777
hi! NvimTreeWinSeparator guifg=#647777
hi! NvimTreeExecFile guifg=#c8d3f5 gui=none
hi! NvimTreeGitDirty guifg=#ff5874
hi! Search guibg=#ffcb8b guifg=#112630
hi! IndentBlanklineSpace guifg=NONE gui=none cterm=none
hi! IndentBlanklineSpaceChar guifg=NONE gui=none cterm=none
hi! MatchParen gui=NONE,bold cterm=NONE,bold guifg=#ff966c
hi! MatchParenCur gui=NONE,nocombine cterm=NONE,nocombine guifg=NONE guibg=NONE
hi! MatchWord cterm=NONE,nocombine gui=NONE,nocombine guibg=NONE guifg=NONE
]]

-- statusline color schemes:
-- import with: require('colors').colorscheme_name
local M = {}

local nightowl = {
  gray1    = '#111111';
  gray2    = '#222222';
  gray3    = '#333333';
  gray4    = '#444444';
  gray7    = '#777777';
  graya    = '#aaaaaa';
  white    = '#d6deeb';
  bright   = '#eeeeee';
  bgblue   = '#011627';
  neardark = '#112630';
  purple   = '#c792ea';
  green    = '#c5e478';
  yellow   = '#ffcb8b';
  gray     = '#637777';
  blue     = '#82aaff';
  yellow2  = '#f78c6c';
  yellow3  = '#fbec9f';
  yellow4  = '#f4d554';
  green2   = '#7fdbca';
  red      = '#ff5874';
  blue2    = '#5ca7e4';
  purple2  = '#2d2c5d';
  hoki     = '#5f7e97';
  error_fg = '#EF5350';
  info_fg  = '#64B5F6';
  warn_fg  = '#FFCA28';
  hint_fg  = '#c51cfd';
  none     = 'NONE';
}

-- My Theme
M.night_owl = {
  bg = '#011627',
  fg = '#d6deeb',
  pink = '#c792ea',
  green = '#c5e478',
  cyan = '#82aaff',
  yellow = '#ffcb8b',
  orange = '#f78c6c',
  red = '#ff5874',
  white = '#bdc7f0',
}

-- Theme: OneDark (dark)
-- Colors: https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
M.onedark_dark = {
  bg = '#282c34',
  fg = '#b2bbcc',
  pink = '#c678dd',
  green = '#98c379',
  cyan = '#56b6c2',
  yellow = '#e5c07b',
  orange = '#d19a66',
  red = '#e86671',
}

-- Theme: Monokai (classic)
-- Colors: https://github.com/tanvirtin/monokai.nvim/blob/master/lua/monokai.lua
M.monokai = {
  bg = '#202328', --default: #272a30
  fg = '#f8f8f0',
  pink = '#f92672',
  green = '#a6e22e',
  cyan = '#66d9ef',
  yellow = '#e6db74',
  orange = '#fd971f',
  red = '#e95678',
}

-- Theme: Rosé Pine (main)
-- Colors: https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/palette.lua
-- color names are adapted to the formats above
M.rose_pine = {
  bg = '#111019', --default: #191724
  fg = '#e0def4',
  pink = '#eb6f92',
  green = '#9ccfd8',
  cyan = '#31748f',
  yellow = '#f6c177',
  orange = '#2a2837',
  red = '#ebbcba',
  anu = {
    nganu = {
      ee
    }
  }
}

return M
