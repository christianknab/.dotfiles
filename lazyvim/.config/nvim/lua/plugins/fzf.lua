return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      local fzf = require("fzf-lua")
      local actions = fzf.actions
      opts = opts or {}
      opts.files = {
        cwd_prompt = false,
        actions = {
          ["ctrl-i"] = { actions.toggle_ignore },
          ["ctrl-h"] = { actions.toggle_hidden },
        },
      }
      opts.grep = {
        actions = {
          ["ctrl-i"] = { actions.toggle_ignore },
          ["ctrl-h"] = { actions.toggle_hidden },
        },
      }
      return opts
    end,
  },
}
