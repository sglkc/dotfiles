local status_ok, neoscroll = pcall(require, 'neoscroll')
if not status_ok then
  return
end

neoscroll.setup({
  respect_scrolloff = true,
  performance_mode = false,
  pre_hook = function()
    vim.opt.eventignore:append({
      'WinScrolled',
      'CursorMoved',
    })
  end,
  post_hook = function()
    vim.opt.eventignore:remove({
      'WinScrolled',
      'CursorMoved',
    })
  end,
})

local t = {}

t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '200'}}
t['<PageUp>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '100'}}
t['<S-Up>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '150'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '200'}}
t['<PageDown>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '100'}}
t['<S-Down>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '150'}}
-- t['gg'] = {'scroll', {'-1*vim.api.nvim_buf_line_count(0)', 'true', '200'}}
-- t['G'] = {'scroll', {'vim.api.nvim_buf_line_count(0)', 'true', '200'}}
t['zt'] = {'zt', {'150'}}
t['zz'] = {'zz', {'150'}}
t['zb'] = {'zb', {'150'}}

require('neoscroll.config').set_mappings(t)
