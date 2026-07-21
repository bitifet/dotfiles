-- ~/.config/nvim/lua/bullet.lua  (or wherever you prefer to put it)
--
-- 🚧 Work in progress...

local M = {}

local bullets = {
  "•",      -- U+2022
  "◦",      -- U+25E6
  "∘",      -- U+2218
  "∙",      -- U+2219
  "⁃",      -- U+2043
  "‒",      -- U+2012
  "–",      -- U+2013 (en dash)
  "★",      -- U+2605
  "✦",      -- U+2726
  "✧",      -- U+2727
  "⬤",      -- U+2B24
  "⚫",      -- U+26AB
  "⚪",      -- U+26AA
}

local function set_bullet_mapping(char)
  if char == "" then
    vim.keymap.del("i", "--", { buffer = 0 })
    print("Bullet mapping removed")
    return
  end

  vim.keymap.set("i", "--", function()
    -- Only convert special keys like <CR>, <BS>, <Space> — do NOT double-process them
    local seq = vim.api.nvim_replace_termcodes("<CR><BS><BS>", true, false, true) .. char .. " "

    -- Alternative one-liner style (same effect):
    -- local seq = vim.api.nvim_replace_termcodes("<CR><BS><BS>%s ", true, false, true):format(char)

    return seq
  end, {
    buffer = 0,
    expr = true,
    desc = "Auto bullet: " .. char,
    noremap = true,
    silent = true,
  })

  print("Bullet mapping set to: " .. char)
end

function M.bullet()
  local items = {}

  -- Add all bullets + empty option
  for _, char in ipairs(bullets) do
    table.insert(items, char .. "   " .. vim.fn.strcharpart(char, 0, 1))
  end
  table.insert(items, "  (none - remove mapping)")

  vim.ui.select(items, {
    prompt = "Select bullet character for '--' mapping:",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if not choice then
      return
    end

    if choice == "  (none - remove mapping)" then
      set_bullet_mapping("")
    else
      -- Extract just the bullet character (first character)
      local bullet = vim.fn.strcharpart(choice, 0, 1)
      set_bullet_mapping(bullet)
    end
  end)
end

-- Optional: create user command
vim.api.nvim_create_user_command("Bullet", M.bullet, {})

return M
