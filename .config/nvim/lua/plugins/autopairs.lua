return {
  {
    'altermo/ultimate-autopair.nvim',
    -- event = { 'InsertEnter', 'CmdlineEnter' },
    lazy = false,
    branch = 'v0.6', --recommended as each new version will have breaking changes
    opts = {
      { '>', '<', disable_start = true, disable_end = true, newline = true , p = 11 },
    },
    config = function(_, opts)
      -- https://github.com/altermo/ultimate-autopair.nvim/issues/46
      local default = require'ultimate-autopair.profile.default.utils'
      local utils = require'ultimate-autopair.utils'
      local function auto_comma()
        local m = {}
        m.doc = 'ultimate-autopair , map'
        m.p = 10

        m.check = function (o)
          local begin = o.line:sub(o.col-1, o.col-1)
          if
            o.mode == 'i' and o.key == ',' and
            (begin == '{' or begin == '(' or begin == '[')
          then
            local pair, col, row = default.get_pair_and_end_pair_pos_from_start(o, o.col, true)
            if not pair then return end
            return utils.create_act{
              { 'j', row-o.row }, { 'home' },
              { 'l', col },
              ',',
              { 'k', row-o.row }, { 'home' },
              { 'l', o.col-1 },
            }
          end
        end
        m.get_map = function (mode) if mode == 'i' then return {','} end end
        return m
      end

      local function trailing_comma()
        local m={}
        m.doc = 'ultimate-autopair backspace map'
        m.p = 11
        m.check = function (o)
          local text = o.line:sub(o.col-1, o.col+1)
          if
            o.mode == 'i' and vim.fn.keytrans(o.key) == '<BS>' and
            (text == '(),' or text == '[],' or text == '{},')
          then
            return utils.create_act{ { 'delete', 1, 2 } }
          end
        end
        m.get_map = function (mode) if mode == 'i' then return {'<bs>'} end end
        return m
      end

      require'ultimate-autopair'.init({
        require'ultimate-autopair'.extend_default(opts),
        { profile='raw', auto_comma() },
        { profile='raw', trailing_comma() },
      })
    end
  }
}
