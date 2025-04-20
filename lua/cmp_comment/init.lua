local cmp = require('cmp')

local source = {}

-- Determine if the source is available in the current context
function source:is_available()
  -- Check if the cursor is in a comment context
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- Convert to 0-based index
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

  if line then
    local before_cursor = line:sub(1, col)
    return before_cursor:match("%s*[%-%-%#//]+") ~= nil
  end

  return false
end

-- Get the keyword pattern for triggering completion
function source:get_keyword_pattern()
  return [[\k*]]
end

-- Get the trigger characters for the source
function source:get_trigger_characters()
  return {"#", "--", "//", "/*"}
end

-- Register the source with cmp.nvim
cmp.register_source('comment', source)

-- Setup function for the plugin
local M = {}
function M.setup(config)
  -- Handle configuration options here
  M.config = config or {}

  -- Use suggestions from the configuration or default suggestions
  M.suggestions = M.config.suggestions or {
    "TODO: ",
    "FIXME: ",
    "NOTE: ",
    "This function handles ",
    "Returns ",
    "Checks whether ",
    "Initializes ",
    "Cleans up ",
  }

  -- Update the complete function to include suggestions
  function source:complete(params, callback)
    local items = {}

    -- Add suggestions from the configuration or defaults
    for _, suggestion in ipairs(M.suggestions) do
      table.insert(items, {
        label = suggestion,
        kind = cmp.lsp.CompletionItemKind.Text,
      })
    end

    -- Add comments from the buffer
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
      local comment = line:match("%s*[%-%-%#//]+%s*(.+)")
      if comment then
        table.insert(items, {
          label = comment,
          kind = cmp.lsp.CompletionItemKind.Text,
        })
      end
    end

    callback({ items = items })
  end
end

return M