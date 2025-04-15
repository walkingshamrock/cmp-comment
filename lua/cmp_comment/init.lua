local source = {}

local user_config = {
  suggestions = {
    "TODO: ",
    "FIXME: ",
    "NOTE: ",
    "This function handles ",
    "Returns ",
    "Checks whether ",
    "Initializes ",
    "Cleans up ",
  }
}

function source.setup(config)
  user_config = vim.tbl_deep_extend("force", user_config, config or {})
end

-- Tree-sitter-based comment detection
local function is_in_comment()
  local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
  if not ok then
    return false
  end

  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type():match("comment") then
      return true
    end
    node = node:parent()
  end
  return false
end

-- Check if source is active in current context
function source:is_available()
  return true
end

-- Provide completion items
function source:complete(_, callback)
  local items = {}
  for _, phrase in ipairs(user_config.suggestions) do
    table.insert(items, {
      label = phrase,
      kind = vim.lsp.protocol.CompletionItemKind.Text,
    })
  end
  callback({ items = items, isIncomplete = false })
end

return source
